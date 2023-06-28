//
//  PokemonResponse.swift
//  obligatorio-final
//
//  Created by Manuela Garcia Lira on 14/6/23.
//

import Foundation
import UIKit

struct PokemonPage: Codable {
    let count: Int
    let next: String
    let results: [Pokemon]
}

struct Pokemon: Codable {
    let name: String
    let url: String
}

struct DetailPokemon: Codable {
    let id: Int
    let weight: Double
    let height: Double
    let stats: [StatContainer]
    let types: [String]
    let name: String
    var url: URL

    private enum CodingKeys: String, CodingKey {
        case id, weight, height, stats, types, name, url
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        weight = try container.decode(Double.self, forKey: .weight)
        height = try container.decode(Double.self, forKey: .height)
        name = try container.decode(String.self, forKey: .name)
        let statArray = try container.decode([StatContainer].self, forKey: .stats)
        stats = statArray
        let typesArray = try container.decode([TypeContainer].self, forKey: .types)
        types = typesArray.map { $0.type.name }
        url = URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/\(id).png")!
    }

}

struct StatContainer: Codable {
    let stat: StatName
    let base_stat: Int
}

struct StatName: Codable {
    let name: String
}

struct TypeContainer: Codable {
    let slot: Int
    let type: TypeInfo
}

struct TypeInfo: Codable {
    let name: String
}

let typesList = ["Normal", "Grass", "Fire", "Water", "Bug", "Electric", "Rock", "Ghost", "Poison", "Psychic", "Fighting", "Ground", "Dragon", "Reset"]
