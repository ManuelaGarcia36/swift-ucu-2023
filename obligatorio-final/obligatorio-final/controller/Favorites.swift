import UIKit
import Foundation

struct FavoritesList {
    var favoritePokemons: [DetailPokemon] = []

    mutating func addFavorite(_ pokemon: DetailPokemon) {
        favoritePokemons.append(pokemon)
    }

    mutating func removeFavorite(_ pokemon: DetailPokemon) {
        favoritePokemons.removeAll { $0.id == pokemon.id }
    }

    func isFavorite(_ pokemon: DetailPokemon) -> Bool {
        return favoritePokemons.contains { $0.id == pokemon.id }
    }
}
