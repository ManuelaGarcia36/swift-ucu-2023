//
//  CustomCollectionViewCell.swift
//  primer-obligatorio
//
//  Created by Manuela Garcia Lira on 3/5/23.
//

import UIKit
import Kingfisher

class CustomCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageBanner: UIImageView!
    
    static let identifier = "CustomCollectionViewCell"
    
    static func nib() -> UINib {
        return UINib(nibName: self.identifier, bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setup(image: URL!){
        // FIXIME: ADD NORMALIZED DATA 
        let url = URL(string: "https://\(image!)")
        imageBanner.kf.setImage(with: url!)
        imageBanner.contentMode = .scaleAspectFill
    }
}

