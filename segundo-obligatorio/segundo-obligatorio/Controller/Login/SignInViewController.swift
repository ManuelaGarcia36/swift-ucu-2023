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
    var userResponse: UserResponse?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        myView.backgroundColor = UIColor.blueLogoView
        myStackView.backgroundColor = UIColor.blueLogoView
        
        pencaImage.image =  UIImage(systemName: "imagen-penca")
        pencaImage.backgroundColor = UIColor.blueLogoView
    }
    
    @IBAction func loginButton(_  sender: Any) {
        if let user = emailText.text, let pass = passwordText.text {
            if user == "" && pass == "" {
                UtilityFunction().simpleAlert(vc: self, title: "Alert! ", message: "Please enter user and password")
            } else if user != "" && pass == "" {
                UtilityFunction().simpleAlert(vc: self, title: "Alert! ", message: "Please enter password")
            } else {
                if !user.isValidEmail(mail: user) {
                    UtilityFunction().simpleAlert(vc: self, title: "Alert! ", message: "Please enter valid mail")
                } else if !pass.isValidPassword(password: pass) {
                    UtilityFunction().simpleAlert(vc: self, title: "Alert! ", message: "Please enter a valid password with at least 8 characters")
                } else {
                    loginWithAPI(email: user, password: pass)
                }
            }
        }
    }
    
    func getTokenUser() -> String  {
        print("dandole el user")
        let tok = userResponse?.token ?? ""
        print(tok)
        return tok;
    }

    func loginWithAPI(email: String, password: String) {
        let parameters: [String: Any] = [
            "email": email,
            "password": password
        ]
        
        APIClient.shared.requestItem(urlString: "https://api.penca.inhouse.decemberlabs.com/api/v1/user/login",
                                     method: .post,
                                     params: parameters,
                                     token: "",
                                     sessionPolicy: .publicDomain) { [weak self] (result: Result<UserResponse, Error>) in
            guard let self = self else { return }
            switch result {
            case .success(let data):
                self.userResponse = data
                if self.userResponse?.token != nil {
                    print("El user tiene token, bienvenido ")
                    DispatchQueue.main.async {
                        let storyboard = UIStoryboard(name: "MainPageScreen", bundle: nil)
                        let destinationVC = storyboard.instantiateViewController(withIdentifier: "MainPageViewControllerID") as! MainPageViewController
                        destinationVC.modalPresentationStyle = .fullScreen
                        destinationVC.setup(user: data);
                        self.present(destinationVC, animated: true)
                    }
                }
            case .failure(let error):
                // Ocurrió un error durante la solicitud
                UtilityFunction().simpleAlert(vc: self, title: "Alert! ", message: "\(error)")
            }
        }
    }
    
}
