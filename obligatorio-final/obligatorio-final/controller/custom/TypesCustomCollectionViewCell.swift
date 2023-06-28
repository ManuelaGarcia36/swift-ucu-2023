//
//  TypesCustomCollectionViewCell.swift
//  obligatorio-final
//
//  Created by Manuela Garcia Lira on 22/6/23.
//

import UIKit

class TypesCustomCollectionViewCell: UICollectionViewCell {

    static let reuseIdentifier :String = "TypesCustomCollectionViewCell"
       
       static func nib() -> UINib {
           return UINib(nibName: self.reuseIdentifier, bundle: nil)
       }
       
    @IBOutlet weak var typeButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
     }
    
    func configure(with name: String) {
        typeButton.isEnabled = true
        typeButton.setTitle(name, for: .normal)
        
        // Configurar esquinas redondeadas
        typeButton.layer.cornerRadius = 15.0
        typeButton.layer.masksToBounds = true
        
        // Configurar fondo de diferentes colores
        let randomColor = UIColor.random()
        typeButton.backgroundColor = randomColor
        
        typeButton.tintColor = .white
    }

}

extension UIColor {
    static func random() -> UIColor {
        let red = CGFloat.random(in: 0...1)
        let green = CGFloat.random(in: 0...1)
        let blue = CGFloat.random(in: 0...1)
        
        return UIColor(red: red, green: green, blue: blue, alpha: 1.0)
    }
}
