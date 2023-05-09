//
//  ConstantVars.swift
//  primer-obligatorio
//
//  Created by Manuela Garcia Lira on 8/5/23.
//

import Foundation
import UIKit

var searchEquipo = [String]()

let equiposIniciales = [
    Equipo(nombre: "Peñarol", imagen: UIImage(named: "escudo-penarol.png")),
    Equipo(nombre: "Club Nacional De Football", imagen: UIImage(named: "escudo-cndf.png")),
    Equipo(nombre: "Uruguay", imagen: UIImage(named: "escudo-uy.png")),
    Equipo(nombre: "Argentina", imagen: UIImage(named: "escudo-arg.png")),
    Equipo(nombre: "Atletico Madrid", imagen: UIImage(named: "escudo-atletico.png")),
    Equipo(nombre: "Barcelona", imagen: UIImage(named: "escudo-bcn.png"))
]

let partidosIniciales = [
    // .errados
    Partido(equipoLocal: equiposIniciales[5], equipoVisitante: equiposIniciales[4], golesLocal: 2, golesVisitante: 1, estado: .errado, fecha: Date(timeIntervalSinceNow: -259200)),
    Partido(equipoLocal: equiposIniciales[2], equipoVisitante: equiposIniciales[5], golesLocal: 2, golesVisitante: 1, estado: .errado, fecha: Date(timeIntervalSinceNow: -259200)),
    Partido(equipoLocal: equiposIniciales[5], equipoVisitante: equiposIniciales[3], golesLocal: 2, golesVisitante: 1, estado: .errado, fecha: Date(timeIntervalSinceNow: -432000)),
    Partido(equipoLocal: equiposIniciales[3], equipoVisitante: equiposIniciales[1], golesLocal: 2, golesVisitante: 2, estado: .errado, fecha: Date(timeIntervalSinceNow: -432000)),
    Partido(equipoLocal: equiposIniciales[0], equipoVisitante: equiposIniciales[1], golesLocal: 2, golesVisitante: 2, estado: .errado, fecha: Date(timeIntervalSinceNow: -432000)),
    // ,acertados
    Partido(equipoLocal: equiposIniciales[3], equipoVisitante: equiposIniciales[2], golesLocal: 2, golesVisitante: 0, estado: .acertado, fecha: Date(timeIntervalSinceNow: -432000)),
    Partido(equipoLocal: equiposIniciales[4], equipoVisitante: equiposIniciales[3], golesLocal: 1, golesVisitante: 2, estado: .acertado, fecha: Date(timeIntervalSinceNow: -432000)),
    Partido(equipoLocal: equiposIniciales[4], equipoVisitante: equiposIniciales[2], golesLocal: 0, golesVisitante: 2, estado: .acertado, fecha: Date(timeIntervalSinceNow: -259200)),
    Partido(equipoLocal: equiposIniciales[0], equipoVisitante: equiposIniciales[5], golesLocal: 0, golesVisitante: 0, estado: .acertado, fecha: Date(timeIntervalSinceNow: -259200)),
    // .jugado
    Partido(equipoLocal: equiposIniciales[2], equipoVisitante: equiposIniciales[3], estado: .jugado, fecha: Date(timeIntervalSinceNow: -518400)),
    Partido(equipoLocal: equiposIniciales[4], equipoVisitante: equiposIniciales[0], estado: .jugado, fecha: Date(timeIntervalSinceNow: -518400)),
    Partido(equipoLocal: equiposIniciales[1], equipoVisitante: equiposIniciales[2], estado: .jugado, fecha: Date(timeIntervalSinceNow: -259200)),
    // .pendiente
    Partido(equipoLocal: equiposIniciales[1], equipoVisitante: equiposIniciales[2], estado: .pendiente, fecha: Date(timeIntervalSinceNow: 259200)),
    Partido(equipoLocal: equiposIniciales[4], equipoVisitante: equiposIniciales[5], estado: .pendiente, fecha: Date(timeIntervalSinceNow: 259200)),
    Partido(equipoLocal: equiposIniciales[3], equipoVisitante: equiposIniciales[0], estado: .pendiente, fecha: Date(timeIntervalSinceNow: 432000)),
    Partido(equipoLocal: equiposIniciales[3], equipoVisitante: equiposIniciales[2], estado: .pendiente, fecha: Date(timeIntervalSinceNow: 432000)),
]

let bannersActivos = [
    UIImage(named: "banner_cndf_penarol.png"),
    UIImage(named: "banner_real_bcn.png"),
    UIImage(named: "banner.png")
]
