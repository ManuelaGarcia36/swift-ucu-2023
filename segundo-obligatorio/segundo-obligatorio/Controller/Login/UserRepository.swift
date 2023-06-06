//
//  UserRepository.swift
//  segundo-obligatorio
//
//  Created by Manuela Garcia Lira on 3/6/23.
//

import Foundation

class UserRepository {
    static let shared = UserRepository()
    
    private var userResponse: User?
    
    func saveUserResponse(_ userResponse: User) {
        self.userResponse = userResponse
    }
    
    func getUserResponse() -> User? {
        return userResponse
    }
}
