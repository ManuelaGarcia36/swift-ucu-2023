//
//  ExtensionDate.swift
//  primer-obligatorio
//
//  Created by Manuela Garcia Lira on 6/5/23.
//

import Foundation
import UIKit

extension Date {
    
    // dado un date devuelve un string con el formato de header necesario para la tabla
    static func dateFromToCustomString(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE dd/MM"
        return dateFormatter.string(from: date)
    }
}
