//
//  ExtensionArray.swift
//  primer-obligatorio
//
//  Created by Manuela Garcia Lira on 8/5/23.
//

import Foundation
import UIKit

extension Array {
    // agrega un subscript adicional que acepta un argumento con una etiqueta personalizada "safe"
    // devuelve un elemento opcional del array
    // para poder acceder a los elementos de un array utilizando la sintaxis de subíndices, de manera que se evita que se genere una excepción por fuera de rango
    subscript (safe index: Int) -> Element? {
        return indices ~= index ? self[index] : nil
    }
}

