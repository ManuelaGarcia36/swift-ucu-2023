//
//  PokemonResponse.swift
//  obligatorio-final
//
//  Created by Manuela Garcia Lira on 14/6/23.
//

import Foundation
import UIKit


struct DetailPokemon: Codable {
    let id: Int
    let weight: Double
    let height: Double
    let hp: Int
    let atk: Int
    let def: Int
    let spd: Int
    let exp: Int
    let name: String
    let types: [String]
}

let listPokemones = [
    DetailPokemon(id: 123, weight: 7.5, height: 0.6, hp: 165, atk: 164, def: 163, spd: 162, exp: 161, name: "clefairy", types: ["fairy"]),
    DetailPokemon(id: 13, weight: 7.5, height: 0.6, hp: 165, atk: 164, def: 163, spd: 162, exp: 161, name: "clefairy", types: ["fairy","flying","bug"]),
    DetailPokemon(id: 13, weight: 7.5, height: 0.6, hp: 165, atk: 164, def: 163, spd: 162, exp: 161, name: "clefairy", types: ["bug","flying"])]

let typesList = ["Normal", "Grass", "Fire", "Water", "Bug", "Electric", "Rock", "Ghost", "Poison", "Psychic", "Fighting", "Ground", "Dragon", "Reset"]
