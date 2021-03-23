//
//  PokemonRouter.swift
//  PokemonApp
//
//  Created by IVAN KHRAMOV on 14.03.2021.
//

import Foundation
import UIKit

class PokemonRouter: PresenterToRouterPokemonsProtocol {
    
    static func createModule() -> UINavigationController {
        let viewController = PokemonViewController()
        let navigationController = UINavigationController(rootViewController: viewController)
        
        let presenter : ViewToPresenterPokemonsProtocol & InteractorToPresenterPokemonsProtocol = PokemonPresenter()
        
        viewController.presenter = presenter
        viewController.presenter?.router = PokemonRouter()
        viewController.presenter?.view = viewController
        viewController.presenter?.interactor = PokemonInteractor()
        viewController.presenter?.interactor?.presenter = presenter
        
        return navigationController
    }
    
//    func pushToPokemonDetail(on view: PresenterToViewPokemonsProtocol, with pokemon: Pokemon) {
//        let pokemonDetailViewController = PokemonDetailRouter.createModule(with: pokemon)
//
//        let viewController = view as! PokemonViewController
//        viewController.navigationController?.pushViewController(pokemonDetailViewController, animated: true)
//    }
}
