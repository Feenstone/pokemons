//
//  APIServiceImpl.swift
//  PokemonApp
//
//  Created by IVAN KHRAMOV on 17.02.2021.
//

import Foundation
import PromiseKit
import Combine

class APIServiceImpl : ObservableObject {
    fileprivate let builder : PokemonRequestBuilder
    
    @Published var pokemons: [Pokemon] = []
    
    private let decoder = JSONDecoder()
    
    init() {
        builder = PokemonRequestBuilder()
    }
}

extension APIServiceImpl: APIService {
    func fetchRequest() -> AnyPublisher<PokeAPIResponse, Error> {
                
        return URLSession.shared.dataTaskPublisher(for: builder.fetchRequest())
            .tryMap({ element -> Data in
                guard let httpResponse = element.response as? HTTPURLResponse,
                      httpResponse.statusCode == 200 else {
                    throw URLError(.badServerResponse)
                }
                return element.data
            })
            .decode(type: PokeAPIResponse.self, decoder: decoder)
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }
    
    func fetchNextRequest(url: URL) -> AnyPublisher<PokeAPIResponse, Error> {
        return URLSession.shared.dataTaskPublisher(for: url)
            .map {$0.data}
            .decode(type: PokeAPIResponse.self, decoder: decoder)
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }
    
    func namedResourceGetter(_ namedURL: NamedURL) -> AnyPublisher<Pokemon, Error> {
        return URLSession.shared.dataTaskPublisher(for: namedURL.url)
            .map { $0.data }
            .decode(type: Pokemon.self, decoder: decoder)
            .eraseToAnyPublisher()
    }
}
