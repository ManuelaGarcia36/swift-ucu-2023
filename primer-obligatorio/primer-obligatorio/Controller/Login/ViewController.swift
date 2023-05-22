//
//  ViewController.swift
//  primer-obligatorio
//
//  Created by Manuela Garcia Lira on 26/4/23.
//
import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var myView: UIView!
    private var userAdminList: [User]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userAdminList = [User(name: "manuela@garcia.com", password: "manu1234"), User(name: "admin@admin.com", password: "admin123")]
        
        myView.backgroundColor = UIColor.blueLogoView
    }
    
    func getUserAdmins() -> [User] {
        return userAdminList;
    }
    
    func updateUserAdmins(user: User) {
        userAdminList.append(user);
    }
        
    func validateUser(user: User) -> Bool {
        if userAdminList.contains(where: { $0.name == user.name && $0.password == user.password})  {
            return true
        } else {
            return false
        }
    }
}
