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

enum ProviderType: String {
    case basic
    case google
}

class AuthenticationViewController: UIViewController {
    
    @IBOutlet weak var headerImage: UIImageView!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var registrationButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        headerImage.image = UIImage(named: "logo_v2")
    
        Analytics.logEvent("InitScreen", parameters: ["message": "Integracion de firebase completa"])
    }
    
     @IBAction func singUpButtonAction(_ sender: Any) {
        if let email = emailTextField.text, let password = passwordTextField.text {
            Auth.auth().createUser(withEmail: email, password: password) {
                (result, error) in
                if let result = result, error == nil {
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    let destinationVC = storyboard.instantiateViewController(withIdentifier: "HomeID") as! HomeViewController
                    destinationVC.modalPresentationStyle = .fullScreen
                    self.navigationController?.pushViewController(destinationVC, animated: true)
                } else {
                    let alertController = UIAlertController(title: "Error", message: "Se ha producido un error regitrando el usuario", preferredStyle: .alert)
                    alertController.addAction(UIAlertAction(title: "Ok", style: .default))
                    self.present(alertController, animated: true, completion: nil)
                }
            }
        }
    }
    
    @IBAction func logInButtonAction(_ sender: Any) {
        if let email = emailTextField.text, let password = passwordTextField.text {
            Auth.auth().signIn(withEmail: email, password: password) {
                (result, error) in
                if let result = result, error == nil {
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    let destinationVC = storyboard.instantiateViewController(withIdentifier: "HomeID") as! HomeViewController
                    destinationVC.modalPresentationStyle = .fullScreen
                    self.navigationController?.pushViewController(destinationVC, animated: true)
                } else {
                    let alertController = UIAlertController(title: "Error", message: "Se ha producido un error regitrando el usuario", preferredStyle: .alert)
                    alertController.addAction(UIAlertAction(title: "Ok", style: .default))
                    self.present(alertController, animated: true, completion: nil)
                }
            }
        }
    }
    
    @IBAction func googleButtonAction(_ sender: Any) {
            
        
    }
    
}
