//
//  Equipo.swift
//  primer-obligatorio
//
//  Created by Manuela Garcia Lira on 1/5/23.
//

import Foundation
import UIKit

class Equipo {
    var nameTeam: String
    var imageTeam: UIImage?
    
    init(nombre: String, imagen: UIImage?) {
        self.nameTeam = nombre
        self.imageTeam = imagen
    }
}
