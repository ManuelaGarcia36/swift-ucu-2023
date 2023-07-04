//
//  UserRepository.swift
//  obligatorio-final
//
//  Created by Manuela Garcia Lira on 3/7/23.
//

import Foundation
import FirebaseAuth

class UserRepository {
    static let shared = UserRepository()
    
    private var user: FirebaseAuth.User?
    
    func getUser() -> FirebaseAuth.User? {
        return user
    }
    
    func updateUser(_ userResponse: FirebaseAuth.User) {
        self.user = userResponse
    }
    
    func reset() {
        self.user = nil
    }
}
