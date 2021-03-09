//
//  NetworkManager.swift
//  PokemonApp
//
//  Created by IVAN KHRAMOV on 09.03.2021.
//

import Foundation
import Combine

class NetworkManager<T: Decodable> {
    func fetch(with url: URLRequest) -> AnyPublisher<T, Error> {
        URLSession.shared.dataTaskPublisher(for: url)
            .map{$0.data}
            .decode(type: T.self, decoder: JSONDecoder())
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }
}
