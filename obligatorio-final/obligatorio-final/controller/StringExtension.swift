//
//  StringExtension.swift
//  obligatorio-final
//
//  Created by Manuela Garcia Lira on 6/7/23.
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
        return length >= 8 ? true: false;
    }
    
}
