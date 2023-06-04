//
//  UserRepository.swift
//  segundo-obligatorio
//
//  Created by Manuela Garcia Lira on 3/6/23.
//

import Foundation

class UserRepository {
    static let shared = UserRepository() // Singleton
    
    private var userResponse: UserResponse?
    
    func saveUserResponse(_ userResponse: UserResponse) {
        self.userResponse = userResponse
    }
    
    func getUserResponse() -> UserResponse? {
        return userResponse
    }
}
