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
    var userResponse: UserResponse?
    
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
               
                createUserWithAPI(email: user, password: pass)
            }
        }
    }
    
    func createUserWithAPI(email: String, password: String) {
        let parameters: [String: Any] = [
            "email": email,
            "password": password
        ]
        
        APIClient.shared.requestItem(urlString: "https://api.penca.inhouse.decemberlabs.com/api/v1/user",
                                     method: .post,
                                     params: parameters,
                                     token: "",
                                     sessionPolicy: .publicDomain) { [weak self] (result: Result<UserResponse, Error>) in
            guard let self = self else { return }
            switch result {
            case .success(let data):
                self.userResponse = data
                if self.userResponse?.token != nil {
                    //FIXME NOTIFICATION USER UtilityFunction().simpleAlert(vc: self, title: "User successfully created! ", message: "Estas listo para hacer login")
                    DispatchQueue.main.async {
                        let storyboard = UIStoryboard(name: "LoginScreen", bundle: nil)
                        let destinationVC = storyboard.instantiateViewController(withIdentifier: "SignInViewControllerID") as! SignInViewController
                        self.present(destinationVC, animated: true)
                    }
                }
            case .failure(let error):
                // Ocurrió un error durante la solicitud
                print("API request error: \(error)")
            }
        }
    }
}
