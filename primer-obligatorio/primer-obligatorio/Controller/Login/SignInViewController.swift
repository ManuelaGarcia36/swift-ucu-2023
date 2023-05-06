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
    
    @IBOutlet weak var pencaImage: UIImageView!
    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let pencImage = UIImage(systemName: "imagen-penca")
        pencaImage.image = pencImage
       // pencaImage.setImage(pencImage, for: .normal)
    }
        
    @IBAction func loginButton(_ sender: Any) {
            
                     //Entro
                     performSegue(withIdentifier: "MainViewController", sender: self)
                 }
                     
     
            
}
