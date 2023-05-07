//
//  UtilityFunction.swift
//  primer-obligatorio
//
//  Created by Manuela Garcia Lira on 26/4/23.
//

import Foundation
import UIKit

class UtilityFunction: NSObject {
    
    func simpleAlert(vc: UIViewController, title: String, message:String) {
        let alert =  UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alert.addAction(okAction)
        vc.present(alert, animated: true)
    }
    
    
    func ordenarPartidos() -> [Date] {
        let partidosOrdenadosPorFecha = partidosIniciales.sorted(by: { (partido1, partido2) -> Bool in
            if let fecha1 = partido1.fecha, let fecha2 = partido2.fecha {
                return fecha1 < fecha2
            } else {
                // handle case where one or both dates are nil
                return false // or true, depending on your logic
            }
        })
        
        
        //  let partidosOrdenadosPorFecha = partidosIniciales.sorted(by: { $0.fecha < $1.fecha })
        var partidosAgrupadosPorFecha = [String: [Partido]]()
        
        for partido in partidosOrdenadosPorFecha {
            guard let fecha = partido.fecha else { continue }
            let fechaString = obtenerFechaComoString(fecha)
            if partidosAgrupadosPorFecha[fechaString] != nil {
                partidosAgrupadosPorFecha[fechaString]?.append(partido)
            } else {
                partidosAgrupadosPorFecha[fechaString] = [partido]
            }
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        let fechasOrdenadas = partidosAgrupadosPorFecha.keys.compactMap { dateFormatter.date(from: $0) }.sorted()
        
        return fechasOrdenadas
    }
    
    func obtenerFechaComoString(_ fecha: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        return formatter.string(from: fecha)
    }
}


let equiposIniciales = [
    Equipo(nombre: "Peñarol", imagen: UIImage(named: "escudo-penarol.png")),
    Equipo(nombre: "Club Nacional De Football", imagen: UIImage(named: "escudo-cndf.png")),
    Equipo(nombre: "Uruguay", imagen: UIImage(named: "escudo-uy.png")),
    Equipo(nombre: "Argentina", imagen: UIImage(named: "escudo-arg.png")),
    Equipo(nombre: "Atletico Madrid", imagen: UIImage(named: "escudo-atletico.png")),
    Equipo(nombre: "Barcelona", imagen: UIImage(named: "escudo-bcn.png"))
]

let partidosIniciales = [
    Partido(equipoLocal: equiposIniciales[0], equipoVisitante: equiposIniciales[1], golesLocal: 2, golesVisitante: 1, estado: .jugado, fecha: Date(timeIntervalSinceNow: -259200)),
    Partido(equipoLocal: equiposIniciales[2], equipoVisitante: equiposIniciales[3], estado: .pendiente, fecha: Date(timeIntervalSinceNow: -259200)),
    Partido(equipoLocal: equiposIniciales[4], equipoVisitante: equiposIniciales[5], estado: .errado, observaciones: "El partido se suspendió debido a la lluvia.", fecha: Date(timeIntervalSinceNow: -259200)),
    Partido(equipoLocal: equiposIniciales[0], equipoVisitante: equiposIniciales[3], estado: .jugado, fecha: Date(timeIntervalSinceNow: -345600)),
    Partido(equipoLocal: equiposIniciales[1], equipoVisitante: equiposIniciales[4], estado: .acertado, fecha: Date(timeIntervalSinceNow: -432000)),
    Partido(equipoLocal: equiposIniciales[2], equipoVisitante: equiposIniciales[0], estado: .pendiente, fecha: Date(timeIntervalSinceNow: -432000))
]

let bannersActivos = [
    UIImage(named: "banner_cndf_penarol.png"),
    UIImage(named: "banner_real_bcn.png"),
    UIImage(named: "banner.png")
]
