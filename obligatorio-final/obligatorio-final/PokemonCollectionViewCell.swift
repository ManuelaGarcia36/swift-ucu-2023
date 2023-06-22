//
//  PokemonCollectionViewCell.swift
//  obligatorio-final
//
//  Created by Manuela Garcia Lira on 22/6/23.
//

import UIKit

class PokemonCollectionViewCell: UICollectionViewCell {

    static let reuseIdentifier :String = "PokemonCollectionViewCell"
       
    static func nib() -> UINib {
       return UINib(nibName: self.reuseIdentifier, bundle: nil)
   }
       
    @IBOutlet weak var cellImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure(with image: UIImage?) {
        //self.cellImageView.isHidden = true
        //backgroundColor = .red
        //TODO: ARREGLAR //cellImageView.image = image
        cellImageView.image = image
    }

}
