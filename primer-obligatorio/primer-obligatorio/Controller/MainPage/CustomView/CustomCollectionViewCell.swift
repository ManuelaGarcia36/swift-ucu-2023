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

extension UIImage {
      func imageWithColor(tintColor: UIColor) -> UIImage {
          UIGraphicsBeginImageContextWithOptions(self.size, false, self.scale)

          let context = UIGraphicsGetCurrentContext()!
          context.translateBy(x: 0, y: self.size.height)
          context.scaleBy(x: 1.0, y: -1.0);
          context.setBlendMode(.normal)

          let rect = CGRect(x: 0, y: 0, width: self.size.width, height: self.size.height) as CGRect
          context.clip(to: rect, mask: self.cgImage!)
          tintColor.setFill()
          context.fill(rect)

          let newImage = UIGraphicsGetImageFromCurrentImageContext()!
          UIGraphicsEndImageContext()

          return newImage
      }
  }
