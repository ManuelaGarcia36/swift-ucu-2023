//
//  Equipo.swift
//  primer-obligatorio
//
//  Created by Manuela Garcia Lira on 1/5/23.
//

import Foundation
import UIKit

class Equipo {
    var nombre: String
    var imagen: UIImage?
    
    init(nombre: String, imagen: UIImage?) {
        self.nombre = nombre
        self.imagen = imagen
    }
}
