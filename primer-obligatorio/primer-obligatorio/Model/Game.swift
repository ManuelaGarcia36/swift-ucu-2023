//
//  Partido.swift
//  primer-obligatorio
//
//  Created by Manuela Garcia Lira on 1/5/23.
//

import Foundation
import UIKit

class Game {
    let localTeam: Team
    let rivalTeam: Team
    var homeTeamGoals: Int
    var awayTeamGoals: Int
    var status: StatusGame
    var observations: [Observation]
    var dateGame: Date?
    
    init(equipoLocal: Team, equipoVisitante: Team, golesLocal: Int = 0, golesVisitante: Int = 0, estado: StatusGame = .pendiente, observations: [Observation] = [], fecha: Date? = nil) {
        self.localTeam = equipoLocal
        self.rivalTeam = equipoVisitante
        self.homeTeamGoals = golesLocal
        self.awayTeamGoals = golesVisitante
        self.status = estado
        self.observations = observations
        self.dateGame = fecha
    }
}

