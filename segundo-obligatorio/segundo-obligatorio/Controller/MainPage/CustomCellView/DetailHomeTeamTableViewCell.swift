//
//  LocalTableViewCell.swift
//  primer-obligatorio
//
//  Created by Manuela Garcia Lira on 13/5/23.
//

import UIKit

class DetailHomeTeamTableViewCell: UITableViewCell {
    
    // outlets
    @IBOutlet weak var minutLabel: UILabel!
    @IBOutlet weak var eventImage: UIImageView!
    @IBOutlet weak var playerNameLabel: UILabel!
    
    static let identifier = "DetailHomeTeamTableViewCell"
    
    static func nib() -> UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = UIColor.blueBackgroundTableView
    }
    
    func setup(minuto: Int, nombre: String, icono: UIImage){
        minutLabel.text = "\(minuto)'"
        minutLabel.textColor = .white
        
        playerNameLabel.textColor = .white
        playerNameLabel.text = nombre
        eventImage.image = icono
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
