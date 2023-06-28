//
//  DetailPokemonTableViewCell.swift
//  obligatorio-final
//
//  Created by Manuela Garcia Lira on 22/6/23.
//

import UIKit

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
    
    func configure(with name: String, stat: Int) {
        statNameLabel.text = name
        var progress = Float(stat) / 300
        if (name == "exp") {
            progress = Float(stat) / 100
        }
        animationStatProgressView.progress = progress
    }
}
