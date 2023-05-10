//
//  UtilityFunction.swift
//  primer-obligatorio
//
//  Created by Manuela Garcia Lira on 26/4/23.
//

import Foundation
import UIKit

class UtilityFunction: NSObject {
    
    // Alerta generica
    func simpleAlert(vc: UIViewController, title: String, message:String) {
        let alert =  UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alert.addAction(okAction)
        vc.present(alert, animated: true)
    }
    
    func ordenarPartidos() -> [Date] {
        let partidosOrdenadosPorFecha = partidosIniciales.sorted(by: { (partido1, partido2) -> Bool in
            if let fecha1 = partido1.dateGame, let fecha2 = partido2.dateGame {
                return fecha1 < fecha2
            } else {
                return false
            }
        })
        
        var partidosAgrupadosPorFecha = [String: [Game]]()
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        
        for partido in partidosOrdenadosPorFecha {
            guard let fecha = partido.dateGame else { continue }
            let fechaString = dateFormatter.string(from: fecha)
            if partidosAgrupadosPorFecha[fechaString] != nil {
                partidosAgrupadosPorFecha[fechaString]?.append(partido)
            } else {
                partidosAgrupadosPorFecha[fechaString] = [partido]
            }
        }
        
        let fechasOrdenadas = partidosAgrupadosPorFecha.keys.compactMap { dateFormatter.date(from: $0) }.sorted()
        
        return fechasOrdenadas
    }
    
}
