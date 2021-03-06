//
//  PokemonPresenter.swift
//  PokemonApp
//
//  Created by IVAN KHRAMOV on 17.02.2021.
//

import Foundation
import SwiftUI
import Combine

class PokemonPresenter : ObservableObject {
    private let interactor: PokemonInteractor
    @Published var pokemons: [Pokemon] = []
    @Published var isLastPage: Bool = false
    @Published var loading: Bool = false {
        didSet {
            if oldValue == false && loading == true {
                self.fetchPokemons()
            }
        }
    }
    private var cancellables = Set<AnyCancellable>()
    private let router = PokemonGridRouter()
    
    
    init(interactor: PokemonInteractor) {
        self.interactor = interactor
        fetchPokemons()
    }
    
    func fetchPokemons(){
        interactor.getPokemons()
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: {_ in}, receiveValue: {pokemons in
                self.pokemons = pokemons.sorted(by: {$0.id < $1.id})
                self.loading = false
            })
            .store(in: &cancellables)
    }
    
    func fetchNextPokemons(){
        if interactor.nextPage == nil {
            isLastPage = true
        }
        interactor.getNextPokemons()
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: {_ in}, receiveValue: {pokemons in
                self.pokemons += pokemons.sorted(by: {$0.id < $1.id})
            })
            .store(in: &cancellables)
    }
    
    func linkBuilder<Content: View>(
        for pokemon: Pokemon,
        @ViewBuilder content: () -> Content
    ) -> some View {
        NavigationLink(
            destination: router.makeDetailView(for: pokemon)) {
            content()
        }
    }
}
