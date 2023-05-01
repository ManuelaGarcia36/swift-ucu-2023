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
    
    init(equipoLocal: Equipo, equipoVisitante: Equipo, golesLocal: Int = 0, golesVisitante: Int = 0, estado: EstadoPartido = .pendiente, observaciones: String? = nil) {
        self.equipoLocal = equipoLocal
        self.equipoVisitante = equipoVisitante
        self.golesLocal = golesLocal
        self.golesVisitante = golesVisitante
        self.estado = estado
        self.observaciones = observaciones
    }
}

enum EstadoPartido {
   case pendiente
   case jugado
   case acertado
   case noAcertado
}
