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
}

extension String {
    
    func isValidEmail(mail: String) -> Bool {
        let regex = "^[\\w-\\.]+@([\\w-]+\\.)+[\\w-]{2,4}$"
        let test = NSPredicate(format: "SELF MATCHES %@", regex)
        let result = test.evaluate(with: mail)
        return result
    }
    
    func isValidPassword(password: String) -> Bool {
        let length = password.count
        return length > 8 ? true: false;
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
    Partido(equipoLocal: equiposIniciales[0], equipoVisitante: equiposIniciales[1], golesLocal: 2, golesVisitante: 1, estado: .jugado),
    Partido(equipoLocal: equiposIniciales[2], equipoVisitante: equiposIniciales[3], estado: .pendiente),
    Partido(equipoLocal: equiposIniciales[4], equipoVisitante: equiposIniciales[5], estado: .noAcertado, observaciones: "El partido se suspendió debido a la lluvia."),
    Partido(equipoLocal: equiposIniciales[0], equipoVisitante: equiposIniciales[3], estado: .pendiente),
    Partido(equipoLocal: equiposIniciales[1], equipoVisitante: equiposIniciales[4], estado: .pendiente),
    Partido(equipoLocal: equiposIniciales[2], equipoVisitante: equiposIniciales[0], estado: .pendiente)
]

let bannersActivos = [
    UIImage(named: "banner_cndf_penarol.png"),
    UIImage(named: "banner_real_bcn.png"),
    UIImage(named: "banner.png")
]
