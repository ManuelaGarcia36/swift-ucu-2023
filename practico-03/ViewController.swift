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
    @IBOutlet weak var FollowingButton: UIButton!
    @IBOutlet weak var moreOptionsButton: UIButton!
    @IBOutlet weak var informationStack: UIStackView!
    @IBOutlet weak var stackResultView: UIView!
    //Colores
    private let primaryColor = UIColor(red: 56/255, green: 117/255, blue: 233/255, alpha: 1)
    private let secondaryColor = UIColor(red: 173/255, green: 202/255, blue: 250/255, alpha:1 )
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Do any additional setup after loading the view.
        perfilImage.layer.cornerRadius = perfilImage.bounds.height / 2
        perfilImage.clipsToBounds = true
        nameLabel.text = "Luis Suarez"
        followersNumberLabel.text = "18M"
        followingNumberLabel.text = "23"
        
        
        let listTitleButtons = ["Post", "Info", "Friends", "More"]
        
        informationStack.axis = .horizontal
        informationStack.alignment = .center
        informationStack.distribution = .fillEqually
        informationStack.spacing = 10
        
        /** for title in listTitleButtons {
         let button = UIButton()
         button.setTitle(title, for: .normal)
         button.setTitleColor(UIColor.black, for: .normal)
         
         informationStack.addArrangedSubview(button)
         } */
        
        
        for title in listTitleButtons {
            let button = UIButton()
            button.setTitle(title, for: .normal)
            button.setTitleColor(.black, for: .normal)
            button.backgroundColor = .white
            button.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
            
            informationStack.addArrangedSubview(button)
        }
        
        
        view.addSubview(informationStack)
        
    }
    
    
    @objc func buttonTapped(_ sender: UIButton) {
        // Deseleccionar los otros botones
        for case let button as UIButton in informationStack.arrangedSubviews where button != sender {
            button.isSelected = false
            button.backgroundColor = .white
        }
        
        // Seleccionar el botón actual
        sender.isSelected = true
        sender.backgroundColor = secondaryColor
        sender.setTitleColor(primaryColor, for: .normal)
        sender.layer.cornerRadius = sender.bounds.height/2
        sender.clipsToBounds = true
        
        
        switch sender.currentTitle {
           case "Post":
               // Mostrar la vista de "Posts"
               //postsView.isHidden = false
               //infoView.isHidden = true
               //friendsView.isHidden = true
            //moreView.isHidden = true
            stackResultView.backgroundColor = .blue
           case "Info":
               // Mostrar la vista de "Información"
            stackResultView.backgroundColor = .yellow
               case "Friends":
               // Mostrar la vista de "Amigos"
            stackResultView.backgroundColor = .green
           case "More":
            stackResultView.backgroundColor = .orange
        default:
               break
           }
        
        
        // Aquí puedes escribir el código para manejar el evento del botón
        print("Button tapped: \(sender.currentTitle ?? "")")
    }
    
}

