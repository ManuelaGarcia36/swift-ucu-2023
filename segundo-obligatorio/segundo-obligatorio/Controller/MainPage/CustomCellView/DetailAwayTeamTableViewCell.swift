//
//  SecondTableViewCell.swift
//  primer-obligatorio
//
//  Created by Manuela Garcia Lira on 15/5/23.
//

import UIKit

class DetailAwayTeamTableViewCell: UITableViewCell {

    static let identifier = "DetailAwayTeamTableViewCell"
    
    static func nib() -> UINib {
        return UINib(nibName: self.identifier, bundle: nil)
    }
    
    // outlets
    @IBOutlet weak var minutLabel: UILabel!
    @IBOutlet weak var iconImage: UIImageView!
    @IBOutlet weak var detailLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = UIColor.blueBackgroundTableView
    }

    func setup(minuto: Int, nombre: String, icono: UIImage){
        minutLabel.text = "\(minuto)'"
        minutLabel.textColor = .white
        
        detailLabel.textColor = .white
        detailLabel.text = nombre
        iconImage.image = icono
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
