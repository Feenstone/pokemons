//
//  ContentView.swift
//  PokemonApp
//
//  Created by IVAN KHRAMOV on 17.02.2021.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        PokemonGridView(viewModel: PokemonViewModel(), builder: PokemonRequestBuilder())
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
