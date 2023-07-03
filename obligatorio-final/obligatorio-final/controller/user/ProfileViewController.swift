//
//  ProfileViewController.swift
//  obligatorio-final
//
//  Created by Manuela Garcia Lira on 3/7/23.
//

import Foundation
import UIKit
import FirebaseAuth

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var headerImageView: UIImageView!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var proveedorLabel: UILabel!
    @IBOutlet weak var logOutButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Profile"
        headerImageView.image = UIImage(named: "logo_v2")
        
        if let currentUser = UserRepository.shared.getUser() {
            emailLabel.text = currentUser.email
            proveedorLabel.text = currentUser.providerID
       }
    }
    
    @IBAction func logOutButtonAction(_ sender: Any) {
        do {
            try Auth.auth().signOut()
            UserRepository.shared.reset()
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let destinationVC = storyboard.instantiateViewController(withIdentifier: "AuthID") as! AuthenticationViewController
            navigationController?.navigationBar.isHidden = true
            self.navigationController?.pushViewController(destinationVC, animated: true)
        } catch {
            print("error al salir de la cuenta")
        }
    }
}
