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
    Team(nombre: "Peñarol", imagen: UIImage(named: "escudo-penarol.png")),
    Team(nombre: "Club Nacional De Football", imagen: UIImage(named: "escudo-cndf.png")),
    Team(nombre: "Uruguay", imagen: UIImage(named: "escudo-uy.png")),
    Team(nombre: "Argentina", imagen: UIImage(named: "escudo-arg.png")),
    Team(nombre: "Atletico Madrid", imagen: UIImage(named: "escudo-atletico.png")),
    Team(nombre: "Barcelona", imagen: UIImage(named: "escudo-bcn.png"))
]

let partidosIniciales = [
    // .errados
    Game(equipoLocal: equiposIniciales[5], equipoVisitante: equiposIniciales[4], golesLocal: 2, golesVisitante: 1, estado: .errado, observations: [
        Observation(minuto: 10, nombre: "Jugador X", tipo: "pelota", equipo: "visitante"),
        Observation(minuto: 15, nombre: "Pepe X", tipo: "roja", equipo: "visitante"),
        Observation(minuto: 83, nombre: "Jugador X", tipo: "amarilla", equipo: "visitante"),
        Observation(minuto: 13, nombre: "Juan X", tipo: "pelota", equipo: "local"),
        Observation(minuto: 17, nombre: "Pedro X", tipo: "pelota", equipo: "local"),
        Observation(minuto: 104, nombre: "Jugador X", tipo: "pelota", equipo: "visitante"),
        Observation(minuto: 25, nombre: "Jugador YYYYYYYYYYYYYYY", tipo: "roja", equipo: "visitante")
    ], fecha: Date(timeIntervalSinceNow: -259200)),
    Game(equipoLocal: equiposIniciales[2], equipoVisitante: equiposIniciales[5], golesLocal: 2, golesVisitante: 1, estado: .errado, observations: [
        Observation(minuto: 10, nombre: "Jugador X", tipo: "pelota", equipo: "visitante"),
        Observation(minuto: 15, nombre: "Pepe X", tipo: "roja", equipo: "local"),
        Observation(minuto: 83, nombre: "Jugador X", tipo: "amarilla", equipo: "visitante"),
        Observation(minuto: 104, nombre: "Jugador X", tipo: "pelota", equipo: "local"),
        Observation(minuto: 25, nombre: "Jugador YYYYYYYYYYYYYYY", tipo: "roja", equipo: "local")
    ], fecha: Date(timeIntervalSinceNow: -598400)),
    Game(equipoLocal: equiposIniciales[5], equipoVisitante: equiposIniciales[3], golesLocal: 2, golesVisitante: 1, estado: .errado, observations: [
        Observation(minuto: 10, nombre: "Jugador X", tipo: "pelota", equipo: "local"),
        Observation(minuto: 100, nombre: "Juan fernando lopez X", tipo: "pelota", equipo: "local"),
        Observation(minuto: 18, nombre: "Jugador X", tipo: "pelota", equipo: "local"),
        Observation(minuto: 25, nombre: "Jugador YYYYYYYYYYYYYYY", tipo: "roja", equipo: "visitante")
    ], fecha: Date(timeIntervalSinceNow: -432000)),
    Game(equipoLocal: equiposIniciales[3], equipoVisitante: equiposIniciales[1], golesLocal: 2, golesVisitante: 2, estado: .errado, observations: [
        Observation(minuto: 10, nombre: "Jugador X", tipo: "pelota", equipo: "local"),
        Observation(minuto: 15, nombre: "Pepe X", tipo: "roja", equipo: "local"),
        Observation(minuto: 17, nombre: "Pedro X", tipo: "pelota", equipo: "visitante"),
        Observation(minuto: 104, nombre: "Jugador X", tipo: "pelota", equipo: "local"),
        Observation(minuto: 25, nombre: "Jugador YYYYYYYYYYYYYYY", tipo: "amarilla", equipo: "local")
    ], fecha: Date(timeIntervalSinceNow: -259200)),
    Game(equipoLocal: equiposIniciales[0], equipoVisitante: equiposIniciales[1], golesLocal: 2, golesVisitante: 2, estado: .errado,observations: [
        Observation(minuto: 10, nombre: "Jugador X", tipo: "pelota", equipo: "local"),
        Observation(minuto: 15, nombre: "Pepe X", tipo: "roja", equipo: "local"),
        Observation(minuto: 83, nombre: "Jugador X", tipo: "amarilla", equipo: "local"),
        Observation(minuto: 13, nombre: "Juan X", tipo: "pelota", equipo: "visitante"),
        Observation(minuto: 17, nombre: "Pedro X", tipo: "pelota", equipo: "visitante"),
        Observation(minuto: 104, nombre: "Jugador X", tipo: "pelota", equipo: "local"),
        Observation(minuto: 25, nombre: "Jugador YYYYYYYYYYYYYYY", tipo: "roja", equipo: "visitante")
    ], fecha: Date(timeIntervalSinceNow: -518400)),
    // ,acertados
    Game(equipoLocal: equiposIniciales[3], equipoVisitante: equiposIniciales[2], golesLocal: 2, golesVisitante: 0, estado: .acertado, observations: [
        Observation(minuto: 10, nombre: "Jugador X", tipo: "pelota", equipo: "visitante"),
        Observation(minuto: 15, nombre: "Pepe X", tipo: "roja", equipo: "local"),
        Observation(minuto: 104, nombre: "Jugador X", tipo: "pelota", equipo: "visitante"),
        Observation(minuto: 25, nombre: "Jugador YYYYYYYYYYYYYYY", tipo: "roja", equipo: "local")
    ], fecha: Date(timeIntervalSinceNow: -432000)),
    Game(equipoLocal: equiposIniciales[4], equipoVisitante: equiposIniciales[3], golesLocal: 1, golesVisitante: 2, estado: .acertado, observations: [
        Observation(minuto: 10, nombre: "Jugador X", tipo: "pelota", equipo: "local"),
        Observation(minuto: 15, nombre: "Pepe X", tipo: "roja", equipo: "visitante"),
        Observation(minuto: 83, nombre: "Jugador X", tipo: "amarilla", equipo: "visitante"),
        Observation(minuto: 25, nombre: "Jugador YYYYYYYYYYYYYYY", tipo: "amarilla", equipo: "visitante")
    ], fecha: Date(timeIntervalSinceNow: -432000)),
    Game(equipoLocal: equiposIniciales[4], equipoVisitante: equiposIniciales[2], golesLocal: 0, golesVisitante: 2, estado: .acertado,observations: [
        Observation(minuto: 10, nombre: "Jugador X", tipo: "pelota", equipo: "visitante"),
        Observation(minuto: 15, nombre: "Pepe X", tipo: "roja", equipo: "local"),
        Observation(minuto: 104, nombre: "Jugador X", tipo: "pelota", equipo: "visitante"),
        Observation(minuto: 25, nombre: "Jugador YYYYYYYYYYYYYYY", tipo: "roja", equipo: "local")
    ], fecha: Date(timeIntervalSinceNow: -518400)),
    Game(equipoLocal: equiposIniciales[0], equipoVisitante: equiposIniciales[5], golesLocal: 0, golesVisitante: 0, estado: .acertado, observations: [
        Observation(minuto: 10, nombre: "Jugador X", tipo: "pelota", equipo: "visitante"),
        Observation(minuto: 15, nombre: "Pepe X", tipo: "roja", equipo: "local"),
        Observation(minuto: 104, nombre: "Jugador X", tipo: "pelota", equipo: "visitante"),
        Observation(minuto: 25, nombre: "Jugador YYYYYYYYYYYYYYY", tipo: "amarilla", equipo: "local")
    ], fecha: Date(timeIntervalSinceNow: -432000)),
    // .jugado
    Game(equipoLocal: equiposIniciales[2], equipoVisitante: equiposIniciales[3], estado: .jugado, observations: [
        Observation(minuto: 10, nombre: "Jugador X", tipo: "pelota", equipo: "visitante"),
        Observation(minuto: 15, nombre: "Pepe X", tipo: "roja", equipo: "local"),
        Observation(minuto: 104, nombre: "Jugador X", tipo: "pelota", equipo: "visitante"),
        Observation(minuto: 25, nombre: "Jugador YYYYYYYYYYYYYYY", tipo: "roja", equipo: "visitante")
    ], fecha: Date(timeIntervalSinceNow: -259200)),
    Game(equipoLocal: equiposIniciales[4], equipoVisitante: equiposIniciales[0], estado: .jugado,observations: [
        Observation(minuto: 10, nombre: "Jugador X", tipo: "pelota", equipo: "visitante"),
        Observation(minuto: 15, nombre: "Pepe X", tipo: "roja", equipo: "local")], fecha: Date(timeIntervalSinceNow: -518400)),
    Game(equipoLocal: equiposIniciales[1], equipoVisitante: equiposIniciales[2], estado: .jugado, observations: [
        Observation(minuto: 10, nombre: "Jugador X", tipo: "pelota", equipo: "local"),
        Observation(minuto: 15, nombre: "Pepe X", tipo: "roja", equipo: "local"),
        Observation(minuto: 83, nombre: "Jugador X", tipo: "amarilla", equipo: "local"),
        Observation(minuto: 13, nombre: "Juan X", tipo: "pelota", equipo: "visitante"),
        Observation(minuto: 17, nombre: "Pedro X", tipo: "pelota", equipo: "visitante"),
        Observation(minuto: 104, nombre: "Jugador X", tipo: "pelota", equipo: "local"),
        Observation(minuto: 25, nombre: "Jugador YYYYYYYYYYYYYYY", tipo: "roja", equipo: "visitante")
    ], fecha: Date(timeIntervalSinceNow: -259200)),
    // .pendiente las obs no deberian llegar a listarse nunca
    Game(equipoLocal: equiposIniciales[1], equipoVisitante: equiposIniciales[2], estado: .pendiente, observations: [
        Observation(minuto: 10, nombre: "Jugador X", tipo: "pelota", equipo: "Local"),
        Observation(minuto: 25, nombre: "Jugador YYYYYYYYYYYYYYY", tipo: "roja", equipo: "visitante")
    ], fecha: Date(timeIntervalSinceNow: 558400)),
    Game(equipoLocal: equiposIniciales[4], equipoVisitante: equiposIniciales[5], estado: .pendiente, observations: [
        Observation(minuto: 10, nombre: "Jugador X", tipo: "pelota", equipo: "Local"),
        Observation(minuto: 25, nombre: "Jugador YYYYYYYYYYYYYYY", tipo: "amarilla", equipo: "visitante")
    ], fecha: Date(timeIntervalSinceNow: 598400)),
    Game(equipoLocal: equiposIniciales[3], equipoVisitante: equiposIniciales[0], estado: .pendiente, observations: [
        Observation(minuto: 10, nombre: "Jugador X", tipo: "pelota", equipo: "Local"),
        Observation(minuto: 25, nombre: "Jugador YYYYYYYYYYYYYYY", tipo: "roja", equipo: "visitante")
    ], fecha: Date(timeIntervalSinceNow: 518400)),
    Game(equipoLocal: equiposIniciales[3], equipoVisitante: equiposIniciales[2], estado: .pendiente, observations: [
        Observation(minuto: 10, nombre: "Jugador X", tipo: "pelota", equipo: "Local"),
        Observation(minuto: 25, nombre: "Jugador YYYYYYYYYYYYYYY", tipo: "roja", equipo: "visitante")
    ], fecha: Date(timeIntervalSinceNow: 259200))

]

let bannersActivos = [
    UIImage(named: "banner_cndf_penarol.png"),
    UIImage(named: "banner_real_bcn.png"),
    UIImage(named: "banner.png")
]
