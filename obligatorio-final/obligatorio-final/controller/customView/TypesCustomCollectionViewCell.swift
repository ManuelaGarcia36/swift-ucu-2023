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
    
    @IBOutlet weak var typeName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setup(with name: String) {
        if (name == "Reset") {
            let fullString = NSMutableAttributedString(string:" Reset")
            // create our NSTextAttachment https://stackoverflow.com/a/59468445
            let image1Attachment = NSTextAttachment()
            image1Attachment.image = UIImage(named: "trash_white")
            image1Attachment.bounds = CGRect(x: 0, y: -3, width: 15, height: 15)
            let image1String = NSAttributedString(attachment: image1Attachment)
            fullString.append(image1String)
            typeName.attributedText = fullString // draw the result in a label
        } else {
            typeName.text = name
        }
        typeName.textColor = .white
        self.backgroundColor = .systemYellow
        self.layer.cornerRadius = 13.0
        self.layer.masksToBounds = true
    }
    
    func changeColor() {
        if (self.backgroundColor == .systemYellow) {
            self.backgroundColor = .red
        } else {
            self.backgroundColor = .systemYellow
        }
    }
}
