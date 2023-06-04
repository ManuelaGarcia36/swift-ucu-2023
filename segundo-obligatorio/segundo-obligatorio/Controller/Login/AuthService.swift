//
//  AuthService.swift
//  segundo-obligatorio
//
//  Created by Manuela Garcia Lira on 3/6/23.
//

import Foundation

class AuthService {
    static let shared = AuthService()
    
    func login(email: String, password: String, completion: @escaping (Result<UserResponse, Error>) -> Void) {
        let parameters: [String: Any] = [
            "email": email,
            "password": password
        ]
        
        APIClient.shared.requestBase(urlString: "https://api.penca.inhouse.decemberlabs.com/api/v1/user/login",
                                     method: .post,
                                     params: parameters,
                                     token: "",
                                     sessionPolicy: .publicDomain) { (result: Result<UserResponse, Error>) in
            completion(result)
        }
    }
    
    func createUser(email: String, password: String, completion: @escaping (Result<UserResponse, Error>) -> Void) {
        let parameters: [String: Any] = [
            "email": email,
            "password": password
        ]
        
        APIClient.shared.requestBase(urlString: "https://api.penca.inhouse.decemberlabs.com/api/v1/user",
                                     method: .post,
                                     params: parameters,
                                     token: "",
                                     sessionPolicy: .publicDomain) { (result: Result<UserResponse, Error>) in
            completion(result)
        }
    }
    
    func deleteUser(completion: @escaping (Result<Dictionary<String, String>, Error>) -> Void) {
        guard let currentUser = UserRepository.shared.getUserResponse() else {
            print("No se encontró ningún usuario actualmente autenticado")
            return
        }
        
        APIClient.shared.requestBase(urlString: "https://api.penca.inhouse.decemberlabs.com/api/v1/user/me",
                                     method: .delete,
                                     params: [:],
                                     token: currentUser.token,
                                     sessionPolicy: .privateDomain) { (result: Result<Dictionary<String, String>, Error>) in
            completion(result)
        }
    }
}

