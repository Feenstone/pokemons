//
//  APIServiceImpl.swift
//  PokemonApp
//
//  Created by IVAN KHRAMOV on 17.02.2021.
//

import Foundation
import PromiseKit
import Combine

class APIService {
    fileprivate let builder = PokemonRequestBuilder()
    
    private let decoder = JSONDecoder()
    
    func fetchRequest() -> AnyPublisher<PokeAPIResponse, Error> {
        NetworkManager<PokeAPIResponse>().fetch(with: builder.fetchRequest())
    }
    
    func fetchNextRequest(url: URL) -> AnyPublisher<PokeAPIResponse, Error> {
        NetworkManager<PokeAPIResponse>().fetch(with: URLRequest(url: url))
    }
    
    func namedResourceGetter(_ namedURL: NamedURL) -> AnyPublisher<Pokemon, Error> {
        NetworkManager<Pokemon>().fetch(with: URLRequest(url: namedURL.url))
    }
}
