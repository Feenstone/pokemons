//
//  PokemonGridRouter.swift
//  PokemonApp
//
//  Created by IVAN KHRAMOV on 01.03.2021.
//

import Foundation
import SwiftUI

class PokemonGridRouter {
    func makeDetailView(for pokemon: Pokemon) -> some View {
        let presenter = PokemonDetailPresenter(pokemon: pokemon)
        let builder = PokemonRequestBuilder()
        return PokemonDetailView(presenter: presenter, builder: builder)
    }
}
