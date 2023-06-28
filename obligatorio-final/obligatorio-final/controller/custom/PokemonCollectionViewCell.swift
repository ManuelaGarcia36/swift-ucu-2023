//
//  PokemonCollectionViewCell.swift
//  obligatorio-final
//
//  Created by Manuela Garcia Lira on 22/6/23.
//

import UIKit
import Kingfisher

class PokemonCollectionViewCell: UICollectionViewCell {

    static let reuseIdentifier :String = "PokemonCollectionViewCell"
       
    static func nib() -> UINib {
       return UINib(nibName: self.reuseIdentifier, bundle: nil)
   }
       
    @IBOutlet weak var contentPokemonImageView: UIView!
    @IBOutlet weak var cellImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure(with imageUrl: URL) {
        cellImageView.kf.setImage(with: imageUrl)
        let randomColor = UIColor.random()
        contentPokemonImageView.backgroundColor = randomColor
        contentPokemonImageView.layer.cornerRadius = 45.0
        contentPokemonImageView.layer.masksToBounds = true
    }

}
