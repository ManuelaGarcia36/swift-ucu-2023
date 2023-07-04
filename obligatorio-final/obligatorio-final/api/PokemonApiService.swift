//
//  PokemonApiService.swift
//  obligatorio-final
//
//  Created by Manuela Garcia Lira on 14/6/23.
//

import Foundation


class PokemonApiService {
    static let shared = PokemonApiService()
    
    func fetchPokemones(page: Int, limit: Int, completion: @escaping ([DetailPokemon]?, Error?) -> Void) {
        // si page 0 = 0 -1 = -1 * 20 = -20
        var offset = 0
        if (page != 0) {
            offset = page * limit
        }
        
        print("obteniendo datos con los parametros: \(offset) y \(limit)")
        let url = "https://pokeapi.co/api/v2/pokemon/?limit=\(limit)&offset=\(offset)"
        
        APIClient.shared.requestItem(urlString: url, method: .get, params: [:], sessionPolicy: .publicDomain) { [self] (result: Result<PokemonPage, Error>) in
            switch result {
            case .success(let response):
                let dispatchGroup = DispatchGroup()
                var detailPokemons: [DetailPokemon] = []
                
                for pokemon in response.results {
                    dispatchGroup.enter()
                    getDetailedPokemon(url: pokemon.url) { [weak self] (details, error) in
                        if let error = error {
                            // Handle error
                        } else {
                            if let pokeDetail = details {
                                detailPokemons.append(pokeDetail)
                            }
                        }
                        dispatchGroup.leave()
                    }
                }
                dispatchGroup.notify(queue: .main) {
                    completion(detailPokemons, nil)
                }

            case .failure(let error):
                completion(nil, error)
            }
        }
    }
    
    func getDetailedPokemon(url: String, _ completion:@escaping (DetailPokemon?, Error?) -> Void) {
        APIClient.shared.requestItem(urlString: url,
                                     method: .get,
                                     params: [:],
                                     sessionPolicy: .publicDomain) { (result: Result<DetailPokemon, Error>) in
            switch result {
                case .success(let response):
                   completion(response, nil)
                case .failure(let error):
                    completion(nil, error)
            }
        }
    }
    
    func fetchPokemonByName(name: String, _ completion:@escaping (DetailPokemon?, Error?) -> Void) {
        let url = "https://pokeapi.co/api/v2/pokemon/\(name)"
        getDetailedPokemon(url: url) { [weak self] (details, error) in
            if let error = error {
                completion(nil, error)
            } else {
                if let pokeDetail = details {
                    completion(pokeDetail, nil)
                } 
            }
        }
    }
}
