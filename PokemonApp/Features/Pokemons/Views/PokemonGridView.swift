//
//  PokemonGridView.swift
//  PokemonApp
//
//  Created by IVAN KHRAMOV on 17.02.2021.
//

import SwiftUI

struct PokemonGridView: View {
    @ObservedObject var viewModel: PokemonViewModel
    var builder : PokemonRequestBuilder
    
    var body: some View {
        NavigationView{
            RefreshableScrollView(height: 70, refreshing: $viewModel.loading) {
            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], alignment: .center, spacing: 20) {
                ForEach(viewModel.pokemons, id: \.id) { item in
                    NavigationLink(destination: PokemonDetailView(pokemon: item, builder: builder)){
                    ZStack {
                    AsyncImage(url: builder.fetchImageURL(id: item.id),
                               placeholder: {Text("Loading ...") },
                               image: { Image(uiImage: $0)
                                .resizable()})
                        .frame(width: 200, height: 200)
                        .aspectRatio(contentMode: .fill)
                    }
                    .overlay(RoundedRectangle(cornerRadius: 14, style: .continuous).stroke(Color.black, lineWidth: 1))
                    .onAppear{
                        if self.shouldLoadNextPage(currentItem: item) {
                            self.viewModel.fetchNextPokemons()
                        }
                    }
                    }
                }
            }
            if viewModel.isLastPage == false {
               ProgressView()
            }
        }
        .navigationBarTitle("Pokemons", displayMode: .inline)
        }
    }
    
    private func shouldLoadNextPage(currentItem item: Pokemon) -> Bool {
        let currentIndex = self.viewModel.pokemons.firstIndex(where: { $0.id == item.id } )
        let lastIndex = self.viewModel.pokemons.count - 1
        let offset = 0
        return currentIndex == lastIndex - offset
    }

struct PokemonGridView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = PokemonViewModel()
        let builder = PokemonRequestBuilder()
        return NavigationView{
        PokemonGridView(viewModel: viewModel, builder: builder)
            }
        }
    }
}
