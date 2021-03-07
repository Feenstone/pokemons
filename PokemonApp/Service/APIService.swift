//
//  APIService.swift
//  PokemonApp
//
//  Created by IVAN KHRAMOV on 17.02.2021.
//

import Foundation
import RxSwift
import Alamofire
import Combine

protocol APIService {
    func request<T:Codable>(_ urlConvertible: URLRequestConvertible) -> Observable<T>
    func fetchRequest() -> Observable<PokeAPIResponse>
    func fetchNextRequest(url: URL) -> Observable<PokeAPIResponse>
    func namedResourceGetter(_ namedURL: NamedURL) -> Observable<Pokemon>
}
