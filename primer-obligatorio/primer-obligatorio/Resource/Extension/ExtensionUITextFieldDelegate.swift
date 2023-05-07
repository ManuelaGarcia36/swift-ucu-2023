//
//  ExtensionUITextFieldDelegate.swift
//  primer-obligatorio
//
//  Created by Manuela Garcia Lira on 7/5/23.
//

import Foundation
import UIKit

extension CustomTableViewCell: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let allowedCharacters = CharacterSet.decimalDigits
        let characterSet = CharacterSet(charactersIn: string)
       
        guard allowedCharacters.isSuperset(of: characterSet) else {
            return false
        }
        let currentText = (textField.text ?? "") as NSString
        let updatedText = currentText.replacingCharacters(in: range, with: string)
        
        // Verificar si el valor es menor que 99
        if let number = Int(updatedText), number < 100 {
            return true
        }
        
        return false
    }
}
