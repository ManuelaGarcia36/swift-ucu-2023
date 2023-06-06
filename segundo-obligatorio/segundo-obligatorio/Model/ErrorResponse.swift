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
    case customError(message: String)
    case invalidToken(String = "Invalid token")
    case userNotFound(String = "User not found")
    case unknownError(String = "Error detected")
}

extension NetworkError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .customError(let message):
            return message
        case .invalidToken:
            return "Invalid token"
        case .userNotFound:
            return "User not found"
        case .unknownError:
            return "Unknown Error"
        }
    }
}
