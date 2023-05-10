//
//  ViewController.swift
//  primer-obligatorio
//
//  Created by Manuela Garcia Lira on 26/4/23.
//
import Foundation
import UIKit

// iniciar session
class SignInViewController: UIViewController {
    
    @IBOutlet var myView: UIView!
    @IBOutlet weak var myStackView: UIStackView!
    @IBOutlet weak var pencaImage: UIImageView!
    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        myView.backgroundColor = blueLogoView
        myStackView.backgroundColor = blueLogoView
        
        pencaImage.image =  UIImage(systemName: "imagen-penca")
        pencaImage.backgroundColor = blueLogoView
    }
    
    @IBAction func loginButton(_ sender: Any) {
        if let user = emailText.text, let pass = passwordText.text{
            if user == "" && pass == "" {
                UtilityFunction().simpleAlert(vc: self, title: "Alert! ", message: "Please enter user and password")
            }else if user != "" && pass == "" {
                UtilityFunction().simpleAlert(vc: self, title: "Alert! ", message: "Please enter password")
            }else {
                if !user.isValidEmail(mail: user){
                    UtilityFunction().simpleAlert(vc: self, title: "Alert! ", message: "Please enter valid mail")
                } else if !pass.isValidPassword(password: pass) {
                    UtilityFunction().simpleAlert(vc: self, title: "Alert! ", message: "Please enter a valid password with at least 8 characters")
                } else {
                    //Entro
                    performSegue(withIdentifier: "MainViewController", sender: self)
                }
            }
        }
    }
}
