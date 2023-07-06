//
//  RegistrationUser.swift
//  obligatorio-final
//
//  Created by Manuela Garcia Lira on 5/7/23.
//

import Foundation
import UIKit
import FirebaseAnalytics
import FirebaseAuth

class RegistrationUserViewController: UIViewController {
    
    @IBOutlet weak var imageHeader: UIImageView!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var passwordCheckTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageHeader.image = UIImage(named: "logoPokemon")
    }
    
    private func simpleAlert(vc: UIViewController, title: String, message:String) {
        let alert =  UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alert.addAction(okAction)
        vc.present(alert, animated: true)
    }
    
    @IBAction func registerUserButton(_ sender: Any) {
        if let user = emailTextField.text, let pass = passwordTextField.text, let passCheck = passwordCheckTextField.text {
            if user == "" && pass == "" && passCheck == "" {
                simpleAlert(vc: self, title: "Alert! ", message: "Please enter user and password")
            } else if user != "" && pass == "" && passCheck  == "" {
                simpleAlert(vc: self, title: "Alert! ", message: "Please enter password")
            } else if pass != passCheck {
                simpleAlert(vc: self, title: "Alert! ", message: "Please check passwords")
            }else {
                if !user.isValidEmail(mail: user) {
                    simpleAlert(vc: self, title: "Alert! ", message: "Please enter valid mail")
                } else if !pass.isValidPassword(password: pass) {
                    simpleAlert(vc: self, title: "Alert! ", message: "Please enter a valid password with at least 8 characters")
                } else {
                    Auth.auth().createUser(withEmail: user, password: pass) {
                        (result, error) in
                        if let result = result, error == nil {
                            UserRepository.shared.updateUser(result.user)
                            let storyboard = UIStoryboard(name: "Main", bundle: nil)
                            let destinationVC = storyboard.instantiateViewController(withIdentifier: "HomeID") as! HomeViewController
                            destinationVC.modalPresentationStyle = .fullScreen
                            self.navigationController?.pushViewController(destinationVC, animated: true)
                        } else {
                            self.simpleAlert(vc: self, title: "Alert! ", message: "Error al intentar crear el usuario")
                        }
                    }
                }
            }
        }
    }
}
