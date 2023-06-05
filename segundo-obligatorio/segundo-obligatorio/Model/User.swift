//
//  User.swift
//  primer-obligatorio
//
//  Created by Manuela Garcia Lira on 22/5/23.
//

import Foundation
import UIKit

struct User: Codable {
    let userId: Int
    let email: String
    let token: String
}
