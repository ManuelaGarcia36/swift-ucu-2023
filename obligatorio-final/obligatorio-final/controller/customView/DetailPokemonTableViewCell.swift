//
//  DetailPokemonTableViewCell.swift
//  obligatorio-final
//
//  Created by Manuela Garcia Lira on 22/6/23.
//

import UIKit
import Kingfisher

class DetailPokemonTableViewCell: UITableViewCell {

    static let reuseIdentifier: String = "DetailPokemonTableViewCell"
    
    static func nib() -> UINib {
        return UINib(nibName: self.reuseIdentifier, bundle: nil)
    }
    
    @IBOutlet weak var animationStatProgressView: UIProgressView!
    @IBOutlet weak var statNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configure(with stat: StatContainer) {
        statNameLabel.text = stat.stat.name
     
        var progress = Float(stat.base_stat) / 300
        if (stat.stat.name == "exp") {
            progress = Float(stat.base_stat) / 100
        }
        
        animationStatProgressView.progressTintColor = UIColor.random() // TODO: Mejorar
        animationStatProgressView.progress = progress
    }
}
