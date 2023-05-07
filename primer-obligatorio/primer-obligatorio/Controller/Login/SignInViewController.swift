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
            
                     //FIXME: RECOVERED CODE
                     performSegue(withIdentifier: "MainViewController", sender: self)
                 }
                     
     
            
}
