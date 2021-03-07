//
//  PokemonInteractor.swift
//  PokemonApp
//
//  Created by IVAN KHRAMOV on 17.02.2021.
//

import Foundation
import Combine
import RxSwift

class PokemonInteractor {
    private let service = APIServiceImpl()
    
    var nextPage : URL?
    
    func getPokemons() -> Observable<[Pokemon]>{
        service.fetchRequest().flatMap({ (response) -> Observable<[Pokemon]> in
            self.nextPage = response.next
            return Observable.zip(response.results.map(self.service.namedResourceGetter))
        })
    }
    
    func getNextPokemons() -> Observable<[Pokemon]> {
        service.fetchNextRequest(url: nextPage!).flatMap({ (response) -> Observable<[Pokemon]> in
            self.nextPage = response.next
            return Observable.zip(response.results.map(self.service.namedResourceGetter))
        })
    }
}
