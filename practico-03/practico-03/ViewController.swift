//
//  ViewController.swift
//  practico-03
//
//  Created by Manuela Garcia Lira on 6/4/23.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var portadaImage: UIImageView!
    @IBOutlet weak var perfilImage: UIImageView!
    @IBOutlet weak var nameLabel: UITextField!
    @IBOutlet weak var followersNumberLabel: UITextField!
    @IBOutlet weak var followingNumberLabel: UITextField!
    @IBOutlet weak var followingButton: UIButton!
    @IBOutlet weak var moreOptionsButton: UIButton!
    @IBOutlet weak var informationStack: UIStackView!
    @IBOutlet weak var containerView: UIView!
    
    //Colores
    private let facebookBlue = UIColor(red: 59/255, green: 89/255, blue: 152/255, alpha: 1.0)
    private let facebookLightBlue = UIColor(red: 179/255, green: 203/255, blue: 252/255, alpha: 1.0)
    private let facebookDarkGray = UIColor(red: 35/255, green: 35/255, blue: 35/255, alpha: 1.0)
    private let facebookLightGray = UIColor(red: 216/255, green: 216/255, blue: 216/255, alpha: 1.0)
    private let facebookWhite = UIColor.white
    private let facebookBlack = UIColor.black

    private let secondaryColor = UIColor(red: 173/255, green: 202/255, blue: 250/255, alpha:1 )
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Normalizacion de la vista
        perfilImage.layer.cornerRadius = perfilImage.bounds.height / 2
        perfilImage.clipsToBounds = true
        perfilImage.layer.borderWidth = 2
        perfilImage.layer.borderColor = UIColor.white.cgColor
        
        nameLabel.text = "Luis Suarez"
        followersNumberLabel.text = "18M"
        followingNumberLabel.text = "23"
        
        followingButton.backgroundColor = facebookBlue
        followingButton.tintColor = facebookWhite
        followingButton.setTitle("Follow", for: .normal)
        let followImage = UIImage(systemName: "person.badge.plus")
        followingButton.setImage(followImage, for: .normal)
        followingButton.layer.cornerRadius = followingButton.bounds.height/4
        
        moreOptionsButton.layer.cornerRadius = moreOptionsButton.bounds.width/4
        moreOptionsButton.backgroundColor = facebookLightGray
        moreOptionsButton.tintColor = facebookBlack
        
        let listTitleButtons = ["Post", "Info", "Friends", "More"]
        
        informationStack.axis = .horizontal
        informationStack.alignment = .center
        informationStack.distribution = .fillEqually
        informationStack.spacing = 10
        
        for title in listTitleButtons {
            let button = UIButton()
            button.setTitle(title, for: .normal)
            button.setTitleColor(facebookBlack, for: .normal)
            button.backgroundColor = facebookWhite
            button.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
            
            informationStack.addArrangedSubview(button)
        }
        view.addSubview(informationStack)
        
    }
    
    
    @objc func buttonTapped(_ sender: UIButton) {
        // Deseleccionar los otros botones
        for case let button as UIButton in informationStack.arrangedSubviews where
        button != sender {
            button.isSelected = false
            button.backgroundColor = facebookWhite
            button.setTitleColor(facebookBlack, for: .normal)
        }
        
        // Seleccionar el botón actual
        sender.isSelected = true
        sender.backgroundColor = facebookLightBlue
        sender.setTitleColor(facebookWhite, for: .normal)
        sender.layer.cornerRadius = sender.bounds.height/2
        sender.clipsToBounds = true
        
        // Obtener una referencia al controlador secundario
        //    guard let postViewController = self.storyboard?.instantiateViewController(withIdentifier: "PostViewController") as? PostViewController else {
           //     return
           // }
        
        switch sender.currentTitle {
              case "Post":
               //postViewController.myPostView.isHidden = false
               containerView.backgroundColor = .white
              case "Info":
               //postViewController.myPostView.isHidden = true
               containerView.backgroundColor = .yellow
                  case "Friends":
               //postViewController.myPostView.isHidden = true
               containerView.backgroundColor = .green
              case "More":
               //postViewController.myPostView.isHidden = true
               containerView.backgroundColor = .orange
           default:
                  break
              }
    }
}

