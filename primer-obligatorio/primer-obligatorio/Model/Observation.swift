//
//  Observation.swift
//  primer-obligatorio
//
//  Created by Manuela Garcia Lira on 15/5/23.
//

import Foundation

struct Observation {
    let minuto: Int
    let nombre: String
    let tipo: String // todo: enum "pelota", "falta" o "amarilla"
    let equipo: String // todo: enum "local" o "visitante"
}
