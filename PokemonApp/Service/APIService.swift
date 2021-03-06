//
//  APIService.swift
//  PokemonApp
//
//  Created by IVAN KHRAMOV on 17.02.2021.
//

import Foundation
import PromiseKit
import Combine

protocol APIService {
    func fetchRequest() -> AnyPublisher<PokeAPIResponse, Error>
    func namedResourceGetter(_ namedURL: NamedURL) -> AnyPublisher<Pokemon, Error>
}
