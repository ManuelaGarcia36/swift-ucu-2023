//
//  Partido.swift
//  primer-obligatorio
//
//  Created by Manuela Garcia Lira on 1/5/23.
//

import Foundation
import UIKit

class Partido {
    let equipoLocal: Equipo
    let equipoVisitante: Equipo
    var golesLocal: Int
    var golesVisitante: Int
    var estado: EstadoPartido
    var observaciones: String?
    var fecha: Date?
    
    init(equipoLocal: Equipo, equipoVisitante: Equipo, golesLocal: Int = 0, golesVisitante: Int = 0, estado: EstadoPartido = .pendiente, observaciones: String? = nil, fecha: Date? = nil) {
        self.equipoLocal = equipoLocal
        self.equipoVisitante = equipoVisitante
        self.golesLocal = golesLocal
        self.golesVisitante = golesVisitante
        self.estado = estado
        self.observaciones = observaciones
        self.fecha = fecha
    }
}

