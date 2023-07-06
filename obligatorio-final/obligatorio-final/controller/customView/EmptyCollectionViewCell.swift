//
//  EmptyCollectionViewCell.swift
//  obligatorio-final
//
//  Created by Manuela Garcia Lira on 28/6/23.
//

import UIKit

class EmptyCollectionViewCell: UICollectionViewCell {

    static let reuseIdentifier :String = "EmptyCollectionViewCell"
       
    static func nib() -> UINib {
       return UINib(nibName: self.reuseIdentifier, bundle: nil)
   }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
