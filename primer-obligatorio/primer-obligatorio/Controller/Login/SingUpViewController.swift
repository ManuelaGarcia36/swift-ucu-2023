//
//  SingUpViewController.swift
//  primer-obligatorio
//
//  Created by Manuela Garcia Lira on 26/4/23.
//

import Foundation
import UIKit

//registrarse
class SingUpViewController: UIViewController {
    
    @IBOutlet var myView: UIView!
    @IBOutlet weak var myStackView: UIStackView!
    @IBOutlet weak var pencaImage: UIImageView!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var mailTex: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    @IBOutlet weak var createButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        myView.backgroundColor = UIColor.blueLogoView
        myStackView.backgroundColor = UIColor.blueLogoView
        
        pencaImage.image = UIImage(systemName: "imagen-penca")
        pencaImage.backgroundColor = UIColor.blueLogoView
    }
    
    @IBAction func saveBtn(_ sender: Any) {
        if let user = mailTex.text, let pass = passwordText.text{
            if user == "" && pass == "" {
                UtilityFunction().simpleAlert(vc: self, title: "Alert! ", message: "Please enter user and password")
            }else if user != "" && pass == "" {
                UtilityFunction().simpleAlert(vc: self, title: "Alert! ", message: "Please enter password")
            }else {
                if !user.isValidEmail(mail: user){
                    UtilityFunction().simpleAlert(vc: self, title: "Alert! ", message: "Please enter valid mail")
                } else if !pass.isValidPassword(password: pass) {
                    UtilityFunction().simpleAlert(vc: self, title: "Alert! ", message: "Please enter a valid password with at least 8 characters")
                }
                let storyboard = UIStoryboard(name: "LoginScreen", bundle: nil)
                let destinationVC = storyboard.instantiateViewController(withIdentifier: "SignInViewController") as! SignInViewController
                self.navigationController?.pushViewController(destinationVC, animated: true)
                // TODO: AGREGAR UN SAVE
            }
        }
    }
    
}
