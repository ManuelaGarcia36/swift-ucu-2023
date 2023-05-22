//
//  ExtensionString.swift
//  primer-obligatorio
//
//  Created by Manuela Garcia Lira on 6/5/23.
//

import Foundation

extension String {
    
    // valida mediante regex el input del usuario
    func isValidEmail(mail: String) -> Bool {
        let regex = "^[\\w-\\.]+@([\\w-]+\\.)+[\\w-]{2,4}$"
        let test = NSPredicate(format: "SELF MATCHES %@", regex)
        let result = test.evaluate(with: mail)
        return result
    }
    
    func isValidPassword(password: String) -> Bool {
        let length = password.count
        return length > 8 ? true: false;
    }
    
}
