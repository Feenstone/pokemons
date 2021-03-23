//
//  PokemonAPIIMpl.swift
//  PokemonApp
//
//  Created by IVAN KHRAMOV on 14.03.2021.
//

import Foundation
import Alamofire
import RxSwift
import Combine

class APIServiceImpl : ObservableObject {
    fileprivate let builder : PokemonRequestBuilder
    
    let decoder = JSONDecoder()
    
    init() {
        builder = PokemonRequestBuilder()
    }
}

extension APIServiceImpl: APIService {
    func request<T:Codable>(_ urlConvertible: URLRequestConvertible) -> Observable<T> {
        return Observable<T>.create { (observer) in
            let request = AF.request(urlConvertible).responseDecodable { (response: DataResponse<T, AFError>) in
                switch response.result {
                case .success(let value):
                    observer.onNext(value)
                    observer.onCompleted()
                case .failure(let error):
                    switch response.response?.statusCode {
                    case 403:
                        observer.onError(APIError(message: "Forbidden"))
                    case 404:
                        observer.onError(APIError(message: "Not Found"))
                    case 409:
                        observer.onError(APIError(message: "Conflict"))
                    case 500:
                        observer.onError(APIError(message: "Internal Server Error"))
                    default:
                        observer.onError(APIError(message: error.localizedDescription))
                    }
                }
            }
            
            return Disposables.create {
                request.cancel()
            }
        }
    }
    
    func fetchRequest() -> Observable<PokeAPIResponse> {
        return request(builder.fetchRequest())
    }
    
    func fetchNextRequest(url: URL) -> Observable<PokeAPIResponse> {
        return request(URLRequest(url: url))
    }
    
    func namedResourceGetter(_ namedURL: NamedURL) -> Observable<Pokemon> {
        return request(URLRequest(url: namedURL.url))
    }
}
