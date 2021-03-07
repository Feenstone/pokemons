//
//  PokemonPresenter.swift
//  PokemonApp
//
//  Created by IVAN KHRAMOV on 17.02.2021.
//

import Foundation
import SwiftUI
import RxSwift
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
    
    private let router = PokemonGridRouter()
    
    private let disposeBag = DisposeBag()
    
    init(interactor: PokemonInteractor) {
        self.interactor = interactor
        fetchPokemons()
    }
    
    func fetchPokemons(){
        interactor.getPokemons()
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { pokemons in
                self.pokemons = pokemons.sorted(by: {$0.id < $1.id})
            }, onError: { error in
                print(error.localizedDescription)
            }, onCompleted: {
                self.loading = false
            })
            .disposed(by: disposeBag)
    }
    
    func fetchNextPokemons(){
        if interactor.nextPage == nil {
            isLastPage = true
        }
        interactor.getNextPokemons()
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: {pokemons in
                self.pokemons += pokemons.sorted(by: {$0.id < $1.id})
            }, onError: { error in
                print(error.localizedDescription)
            })
            .disposed(by: disposeBag)
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
