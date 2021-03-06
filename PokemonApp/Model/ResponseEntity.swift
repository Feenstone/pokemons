//
//  ResponseEntity.swift
//  PokemonApp
//
//  Created by IVAN KHRAMOV on 19.02.2021.
//

import Foundation
import ObjectMapper

struct NamedURL: Codable {
    let name: String
    let url: URL
}

struct PokeAPIResponse: Codable {
    let next: URL
    let results: [NamedURL]
}
