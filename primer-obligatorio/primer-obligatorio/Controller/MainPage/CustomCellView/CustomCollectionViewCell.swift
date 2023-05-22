//
//  CustomCollectionViewCell.swift
//  primer-obligatorio
//
//  Created by Manuela Garcia Lira on 3/5/23.
//

import UIKit

class CustomCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageBanner: UIImageView!
    
    static let identifier = "CustomCollectionViewCell"
    
    static func nib() -> UINib {
        return UINib(nibName: self.identifier, bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setup(image: UIImage!){
        imageBanner.image = image
        imageBanner.contentMode = .scaleAspectFill
    }
}

