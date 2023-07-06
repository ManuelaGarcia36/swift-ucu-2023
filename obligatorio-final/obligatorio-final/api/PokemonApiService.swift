//
//  PokemonApiService.swift
//  obligatorio-final
//
//  Created by Manuela Garcia Lira on 14/6/23.
//

import Foundation


class PokemonApiService {
    static let shared = PokemonApiService()
    var pokemonPageData: PokemonPage?
    
    func fetchPokemones(page: Int, limit: Int, completion: @escaping ([DetailPokemon]?, Error?) -> Void) {
        var url = "https://pokeapi.co/api/v2/pokemon/?offset=0&limit=20"
        if let pokemon = pokemonPageData {
            url = pokemon.next
        }
        
        APIClient.shared.requestBase(urlString: url, method: .get, params: [:], sessionPolicy: .publicDomain) { [self] (result: Result<PokemonPage, Error>) in
            switch result {
            case .success(let response):
                pokemonPageData = response
                let dispatchGroup = DispatchGroup()
                var detailPokemons: [DetailPokemon] = []
                
                for pokemon in response.results {
                    dispatchGroup.enter()
                    getDetailedPokemon(url: pokemon.url) { [weak self] (details, error) in
                        if let error = error {
                            completion(nil, error)
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
    
    func fetchPokemonesByIterator(page: Int, limit: Int, completion: @escaping ([DetailPokemon]) -> Void) {
        let offset = page * limit
        let dispatchGroup = DispatchGroup()
        var detailPokemons: [DetailPokemon] = []
        for i in offset...(offset + 20) {
            dispatchGroup.enter()
            getDetailedPokemon(url: "https://pokeapi.co/api/v2/pokemon/\(i)") { [weak self] (details, error) in
                if let error = error {
                    print("Ocurrió un error intentando acceder al detalle del Pokémon con ID: \(i) error: \(error)")
                } else {
                    if let pokeDetail = details {
                        detailPokemons.append(pokeDetail)
                    }
                }
                dispatchGroup.leave()
            }
        }
        
        dispatchGroup.notify(queue: .main) {
            detailPokemons.sort { $0.id < $1.id }
            detailPokemons = Array(Set(detailPokemons))
            completion(detailPokemons)
        }
    }
    
    func getDetailedPokemon(url: String, _ completion:@escaping (DetailPokemon?, Error?) -> Void) {
        APIClient.shared.requestBase(urlString: url,
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
