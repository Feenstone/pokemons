//
//  PokemonViewModel.swift
//  PokemonApp
//
//  Created by IVAN KHRAMOV on 09.03.2021.
//

import Foundation
import Combine

class PokemonViewModel : ObservableObject {
    @Published var pokemons = [Pokemon]()
    @Published var isLastPage: Bool = false
    @Published var loading: Bool = false {
        didSet {
            if oldValue == false && loading == true {
                self.fetchPokemons()
            }
        }
    }
    
    private var cancellables = Set<AnyCancellable>()
    
    private let service = APIService()
    
    private var nextPageURL: URL?
    
    init() {
        fetchPokemons()
    }
    
    func fetchPokemons() {
        service.fetchRequest().map{response -> PokeAPIResponse in
            self.nextPageURL = response.next
            return response
        }
        .flatMap { (response) in
            Publishers.MergeMany(
                response.results.map(self.service.namedResourceGetter)
            )
            .collect()
        }
        .receive(on: RunLoop.main)
        .sink(receiveCompletion: {_ in}, receiveValue: {pokemons in
            self.pokemons = pokemons.sorted(by: {$0.id < $1.id})
            self.loading = false
        })
        .store(in: &cancellables)
    }
    
    func fetchNextPokemons() {
        guard let nextPage = nextPageURL else {
            isLastPage = true
            return
        }
        
        service.fetchNextRequest(url: nextPage).map{response -> PokeAPIResponse in
            self.nextPageURL = response.next
            return response
        }
        .flatMap { (response) in
            Publishers.MergeMany(
                response.results.map(self.service.namedResourceGetter)
            )
            .collect()
        }
        .receive(on: RunLoop.main)
        .sink(receiveCompletion: {_ in}, receiveValue: {pokemons in
            self.pokemons += pokemons.sorted(by: {$0.id < $1.id})
        })
        .store(in: &cancellables)
    }}
