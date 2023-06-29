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
    
    func setup(with name: String) {
        typeButton.isEnabled = true
        typeButton.setTitle(name, for: .normal)
        typeButton.layer.cornerRadius = 15.0
        typeButton.layer.masksToBounds = true
        typeButton.backgroundColor =  UIColor.random()
        typeButton.tintColor = .white
    }
    
}
