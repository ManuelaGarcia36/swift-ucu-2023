//
//  ExtensionString.swift
//  primer-obligatorio
//
//  Created by Manuela Garcia Lira on 6/5/23.
//

import Foundation

extension String {
    
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
    
    func isValidInput(input: String) -> Bool {
        let regex = "^(0|[1-9][0-9]?)$"
        let predicate = NSPredicate(format: "SELF MATCHES %@", regex)
        
        return predicate.evaluate(with: input)
    }
    
}
