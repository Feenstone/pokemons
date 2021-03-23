//
//  PokemonContract.swift
//  PokemonApp
//
//  Created by IVAN KHRAMOV on 14.03.2021.
//

import Foundation
import RxSwift
import UIKit

protocol ViewToPresenterPokemonsProtocol: class {
    var view: PresenterToViewPokemonsProtocol? { get set }
    var interactor: PresenterToInteractorPokemonsProtocol? { get set }
    var router: PresenterToRouterPokemonsProtocol? { get set }
    var pokemons: [Pokemon]? { get set }
    func viewDidLoad()
    func refresh()
}

protocol PresenterToViewPokemonsProtocol: class {
    func onFetchPokemonsSuccess()
    func onFetchPokemonsFailure(error: String)
}

protocol PresenterToInteractorPokemonsProtocol: class {
    var presenter: InteractorToPresenterPokemonsProtocol? { get set }
    func loadPokemons()
    func loadNextPokemons()
}

protocol InteractorToPresenterPokemonsProtocol: class {
    func fetchPokemonsSuccess(pokemons: [Pokemon])
    func fetchPokemonsFailure(error: String)
//    func getPokemonSuccess(_ pokemon: Pokemon)
    func getPokemonFailure()
}

protocol PresenterToRouterPokemonsProtocol: class {
    static func createModule() -> UINavigationController
//    func pushToPokemonDetail(on view: PresenterToViewPokemonsProtocol, with pokemon: Pokemon)
}
