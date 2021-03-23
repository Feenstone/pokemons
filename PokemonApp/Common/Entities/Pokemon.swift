//
//  PokemonEntity.swift
//  PokemonApp
//
//  Created by IVAN KHRAMOV on 14.03.2021.
//

import Foundation

struct NamedURL: Codable {
    let name: String
    let url: URL
}

struct PokeAPIResponse: Codable {
    let next: URL
    let results: [NamedURL]
}
