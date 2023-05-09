//
//  Partido.swift
//  primer-obligatorio
//
//  Created by Manuela Garcia Lira on 1/5/23.
//

import Foundation
import UIKit

class Partido {
    let localTeam: Equipo
    let rivalTeam: Equipo
    var homeTeamGoals: Int
    var awayTeamGoals: Int
    var status: EstadoPartido
    var observations: String?
    var dateGame: Date?
    
    init(equipoLocal: Equipo, equipoVisitante: Equipo, golesLocal: Int = 0, golesVisitante: Int = 0, estado: EstadoPartido = .pendiente, observaciones: String? = nil, fecha: Date? = nil) {
        self.localTeam = equipoLocal
        self.rivalTeam = equipoVisitante
        self.homeTeamGoals = golesLocal
        self.awayTeamGoals = golesVisitante
        self.status = estado
        self.observations = observaciones
        self.dateGame = fecha
    }
}

