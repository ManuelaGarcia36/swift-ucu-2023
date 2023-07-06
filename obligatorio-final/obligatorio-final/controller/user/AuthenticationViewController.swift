//
//  AuthenticationViewController.swift
//  obligatorio-final
//
//  Created by Manuela Garcia Lira on 3/7/23.
//

import Foundation
import UIKit
import FirebaseAnalytics
import FirebaseAuth

class AuthenticationViewController: UIViewController {
    
    @IBOutlet weak var headerImage: UIImageView!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var registrationButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        headerImage.image = UIImage(named: "logoPokemon")
        
        Analytics.logEvent("InitScreen", parameters: ["message": "Integracion de firebase completa"])
    }
    
    private func simpleAlert(vc: UIViewController, title: String, message:String) {
        let alert =  UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alert.addAction(okAction)
        vc.present(alert, animated: true)
    }
    
    @IBAction func logInButtonAction(_ sender: Any) {
        if let user = emailTextField.text, let pass = passwordTextField.text {
            if user == "" && pass == "" {
                simpleAlert(vc: self, title: "Alert! ", message: "Please enter user and password")
            } else if user != "" && pass == "" {
                simpleAlert(vc: self, title: "Alert! ", message: "Please enter password")
            } else {
                if !user.isValidEmail(mail: user) {
                    simpleAlert(vc: self, title: "Alert! ", message: "Please enter valid mail")
                } else if !pass.isValidPassword(password: pass) {
                    simpleAlert(vc: self, title: "Alert! ", message: "Please enter a valid password with at least 8 characters")
                } else {
                    Auth.auth().signIn(withEmail: user, password: pass) {
                        (result, error) in
                        if let result = result, error == nil {
                            UserRepository.shared.updateUser(result.user)
                            let storyboard = UIStoryboard(name: "Main", bundle: nil)
                            let destinationVC = storyboard.instantiateViewController(withIdentifier: "HomeID") as! HomeViewController
                            destinationVC.modalPresentationStyle = .fullScreen
                            self.navigationController?.pushViewController(destinationVC, animated: true)
                        } else {
                            self.simpleAlert(vc: self, title: "Alert! ", message: "Error al intentar hacer login")
                        }
                    }
                }
            }
        }
    }
}
