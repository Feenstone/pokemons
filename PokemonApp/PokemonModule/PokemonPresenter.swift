//
//  PokemonPresenter.swift
//  PokemonApp
//
//  Created by IVAN KHRAMOV on 14.03.2021.
//

import Foundation

class PokemonPresenter : ViewToPresenterPokemonsProtocol {
    
    weak var view: PresenterToViewPokemonsProtocol?
    var interactor: PresenterToInteractorPokemonsProtocol?
    var router: PresenterToRouterPokemonsProtocol?
    
    var pokemons: [Pokemon]?
    
    func viewDidLoad() {
        print("Presenter is being notified that View was loaded.")
        interactor?.loadPokemons()
    }
    
    func refresh() {
        print("Presenter is being notified that the View was refreshed.")
        interactor?.loadPokemons()
    }
}

extension PokemonPresenter: InteractorToPresenterPokemonsProtocol {
    func fetchPokemonsSuccess(pokemons: [Pokemon]) {
        print("Presenter receives the result from Interactor after it's done its job.")
        self.pokemons = pokemons
        view?.onFetchPokemonsSuccess()
    }
    
    func fetchPokemonsFailure(error: String) {
        print("Presenter receives the result from Interactor after it's done its job.")
        view?.onFetchPokemonsFailure(error: "Couldn't fetch pokemons: \(error)")
    }
    
//    func getPokemonSuccess(_ pokemon: Pokemon) {
//        router?.pushToPokemonDetail(on: view!, with: pokemon)
//    }
    
    func getPokemonFailure() {
        print("Couldn't retrieve pokemon by index")
    }
    
    
}
