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
    @IBOutlet weak var providerLabel: UILabel!
    @IBOutlet weak var logoutButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Profile"
        headerImageView.image = UIImage(named: "logoPokemon")
        
        if let currentUser = UserRepository.shared.getUser() {
            emailLabel.text = currentUser.email
            providerLabel.text = currentUser.providerID
       }
    }
    
    @IBAction func logoutButtonAction(_ sender: Any) {
        do {
            try Auth.auth().signOut()
            UserRepository.shared.reset()
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let destinationVC = storyboard.instantiateViewController(withIdentifier: "AuthID") as! AuthenticationViewController
            navigationController?.navigationBar.isHidden = true
            self.navigationController?.pushViewController(destinationVC, animated: true)
        } catch {
            print("Error al hacer logout de la cuenta")
        }
    }
}
