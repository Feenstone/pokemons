//
//  PokemonRequestBuilder.swift
//  PokemonApp
//
//  Created by IVAN KHRAMOV on 14.03.2021.
//

import Foundation

import Alamofire

class PokemonRequestBuilder {
    let showImageEndPoint : String = "https://pokeres.bastionbot.org/images/pokemon/"
    
    let endPoint: String = "https://pokeapi.co/api/v2/pokemon/?limit=10&offset=0"
    
    func fetchRequest() -> URLRequest {
        let url = endPoint
        return try! URLEncoding.default.encode(URLRequest(url: url, method: .get), with: nil)
    }
    
    func requestUrl(path: String) -> URLConvertible {
        return endPoint + path
    }
    
    
    func fetchPokemon(url: String) -> URLRequest {
        let url = url
        return try! URLEncoding.default.encode(URLRequest(url: url, method: .get), with: nil)
    }
    
    func fetchImageURL(id: Int) -> URL {
        let url = showImageEndPoint
        return URL(string: url + String(id) + ".png")!
    }
}
