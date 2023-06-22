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
    typeButton.titleLabel?.text = name
   }
}
