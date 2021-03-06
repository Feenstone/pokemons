//
//  PokemonDetailView.swift
//  PokemonApp
//
//  Created by IVAN KHRAMOV on 01.03.2021.
//

import SwiftUI
import Combine

struct PokemonDetailView: View {
    @ObservedObject var presenter: PokemonDetailPresenter
    var builder : PokemonRequestBuilder
    
    var body: some View {
        List{
            AsyncImage(url: builder.fetchImageURL(id: presenter.pokemon.id),
                       placeholder: {Text("Loading...")},
                       image: {Image(uiImage: $0)
                        .resizable()
                       }
            )
            .frame(height: 400)
            Text(presenter.pokemon.name)
            ForEach(presenter.pokemon.stats, id: \.id){ stat in
                Text(stat.stat.name + " : " + stat.baseStat.description)
            }
            Text("weigth : " + presenter.pokemon.weight.description)
        }
    }
}

#if DEBUG
struct PokemonDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let builder = PokemonRequestBuilder()
        let presenter = PokemonDetailPresenter(pokemon: Pokemon(id: 1, name: "Bulba", stats: [], weight: 100))
        return NavigationView {
            PokemonDetailView(presenter: presenter, builder: builder)
        }
    }
}
#endif
