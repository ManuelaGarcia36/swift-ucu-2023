//
//  PokemonApiService.swift
//  obligatorio-final
//
//  Created by Manuela Garcia Lira on 14/6/23.
//

import Foundation

/**
class PokemonApiService {
    static let shared = PokemonApiService()
    
    func fetchPokemones(completion: @escaping ([DetailPokemon]?, Error?) -> Void) {
        let url = "https://pokeapi.co/api/v2/pokemon/?limit=20&offset=20"
        APIClient.shared.requestBase(urlString: url,
                                     method: .get,
                                     params: [:],
                                     token: "",
                                     sessionPolicy: .publicDomain) { (result: Result<DetailPokemon, Error>) in
        
            switch result {
            case .success(let response):
                var pokemonsWithDetails: [DetailPokemon] = []
                
                let dispatchGroup = DispatchGroup()
                
                for pokemon in response.results {
                    dispatchGroup.enter()
                    
                    APIClient.shared.requestBase(urlString: pokemon.url,
                                                 method: .get,
                                                 params: [:],
                                                 token: "",
                                                 sessionPolicy: .publicDomain) { (result: Result<DetailPokemon, Error>) in
                        switch result {
                        case .success(let detailPokemon):
                            pokemonsWithDetails.append(detailPokemon)
                        case .failure(let error):
                            // Manejar el error de la solicitud del detalle del Pokémon
                            print("Error obteniendo detalles del Pokémon \(pokemon.name): \(error)")
                        }
                        
                        dispatchGroup.leave()
                    }
                }
                
                dispatchGroup.notify(queue: .main) {
                    print("Lista de pokemones \(pokemonsWithDetails)")
                    completion(pokemonsWithDetails, nil)
                }
            case .failure(let error):
                completion(nil, error)
            }
        }
    }

}
 */
