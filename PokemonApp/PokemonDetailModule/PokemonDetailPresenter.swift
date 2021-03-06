//
//  PokemonDetailPresenter.swift
//  PokemonApp
//
//  Created by IVAN KHRAMOV on 01.03.2021.
//

import Foundation

class PokemonDetailPresenter: ObservableObject {
    let pokemon: Pokemon
    
    init(pokemon: Pokemon) {
        self.pokemon = pokemon
    }
}
