//
//  ErrorAPi.swift
//  segundo-obligatorio
//
//  Created by Manuela Garcia Lira on 4/6/23.
//

import Foundation

struct ErrorResponse: Decodable {
    let message: String
}

enum NetworkError : Error {
    case userNotFound
    case timeOut
}
