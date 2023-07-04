import UIKit
import Foundation

class FavoritesRepository {
    static let shared = FavoritesRepository()
    
    private var favoritePokemons: [DetailPokemon] = []

    func addFavorite(_ pokemon: DetailPokemon) {
        favoritePokemons.append(pokemon)
    }

    func removeFavorite(_ pokemon: DetailPokemon) {
        favoritePokemons.removeAll { $0.id == pokemon.id }
    }

    func isFavorite(_ pokemon: DetailPokemon) -> Bool {
        return favoritePokemons.contains { $0.id == pokemon.id }
    }
    
    func getList() -> [DetailPokemon] {
        return favoritePokemons
    }
}
