//
//  PokemonInteractor.swift
//  PokemonApp
//
//  Created by IVAN KHRAMOV on 14.03.2021.
//

import Foundation
import RxSwift

class PokemonInteractor : PresenterToInteractorPokemonsProtocol {
    
    var presenter: InteractorToPresenterPokemonsProtocol?
    var pokemons: [Pokemon]?
    private let service = APIServiceImpl()
    
    var nextPage : URL?
    
    func loadPokemons() {
        service.fetchRequest().subscribe(onNext: { (response) in
            self.nextPage = response.next
            Observable.zip(response.results.map(self.service.namedResourceGetter)).subscribe { (pokemons) in
                self.presenter?.fetchPokemonsSuccess(pokemons: pokemons.sorted(by: {$0.id < $1.id}))
            } onError: { (error) in
                self.presenter?.fetchPokemonsFailure(error: error.localizedDescription)
            }
        })
    }
    
    func loadNextPokemons() {
        service.fetchNextRequest(url: nextPage!).subscribe(onNext: { (response) in
            self.nextPage = response.next
            Observable.zip(response.results.map(self.service.namedResourceGetter)).subscribe { (pokemons) in
                self.presenter?.fetchPokemonsSuccess(pokemons: pokemons.sorted(by: {$0.id < $1.id}))
            } onError: { (error) in
                self.presenter?.fetchPokemonsFailure(error: error.localizedDescription)
            }
        })
    }
}
