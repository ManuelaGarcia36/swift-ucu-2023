//
//  CustomCollectionViewCell.swift
//  primer-obligatorio
//
//  Created by Manuela Garcia Lira on 3/5/23.
//

import UIKit

class CustomCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imageBanner: UIImageView!
    
    static let reuseIdentifier :String = "CustomCollectionViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setup(image: UIImage!){
        imageBanner.image = image
        imageBanner.contentMode = .scaleAspectFill
    }
}
