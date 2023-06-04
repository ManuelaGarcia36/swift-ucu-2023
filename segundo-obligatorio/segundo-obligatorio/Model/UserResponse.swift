//
//  User.swift
//  primer-obligatorio
//
//  Created by Manuela Garcia Lira on 22/5/23.
//

import Foundation
import UIKit

struct UserResponse: Codable {
    let userId: Int
    let email: String
    let token: String
}

// todo: separar
enum CustomError: Error {
    case invalidToken
    case userNotFound
    case otherError(String)  // Puedes agregar más casos según tus necesidades
}
