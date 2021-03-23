//
//  ResponseEntity.swift
//  PokemonApp
//
//  Created by IVAN KHRAMOV on 14.03.2021.
//

import Foundation

struct Pokemon: Codable {
    let id: Int
    let name: String
    let stats: [Stat]
    let weight: Double
}

struct Stat: Codable {
    
    let id = UUID()
    let baseStat: Int
    let effort: Int
    let stat: NamedURL

    enum CodingKeys: String, CodingKey {
        case baseStat = "base_stat"
        case effort
        case stat
    }
}
