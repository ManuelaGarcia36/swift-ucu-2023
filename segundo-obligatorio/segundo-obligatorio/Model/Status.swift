//
//  EstadoPartido.swift
//  primer-obligatorio
//
//  Created by Manuela Garcia Lira on 6/5/23.
//

import Foundation
import UIKit

enum Status: String, Codable {
   case pending
   case not_predicted
   case correct
   case incorrect
}
