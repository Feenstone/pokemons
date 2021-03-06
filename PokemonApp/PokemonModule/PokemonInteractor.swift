//
//  PokemonInteractor.swift
//  PokemonApp
//
//  Created by IVAN KHRAMOV on 17.02.2021.
//

import Foundation
import Combine

class PokemonInteractor {
    private let service = APIServiceImpl()
    
    var nextPage : URL?
    
    init() {
        nextPage = URL(string: "1")
    }
    
    func getPokemons() -> AnyPublisher<[Pokemon], Error>{
        service.fetchRequest().compactMap({ (response) -> PokeAPIResponse in
            self.nextPage = response.next
            return response
        }).flatMap{response in
            Publishers.MergeMany(
                response.results.map(self.service.namedResourceGetter)
            )
            .collect()
        }
        .eraseToAnyPublisher()
    }
    
    func getNextPokemons() -> AnyPublisher<[Pokemon], Error> {
        service.fetchNextRequest(url: nextPage!).compactMap({ (response) -> PokeAPIResponse in
            self.nextPage = response.next
            return response
        }).flatMap{response in
            Publishers.MergeMany(
                response.results.map(self.service.namedResourceGetter)
            )
            .collect()
        }
        .eraseToAnyPublisher()
    }
}
