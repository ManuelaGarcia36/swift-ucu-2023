//
//  LocalTableViewCell.swift
//  primer-obligatorio
//
//  Created by Manuela Garcia Lira on 13/5/23.
//

import UIKit

class FirstTableViewCell: UITableViewCell {
    
    static let identifier = "FirstTableViewCell"
    
    static func nib() -> UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    // outlets
    @IBOutlet weak var minutLabel: UILabel!

    @IBOutlet weak var iconImage: UIImageView!
    
    @IBOutlet weak var detailsLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        backgroundColor = UIColor.blueBackgroundTableView
    }

    func setup(minuto: Int, nombre: String, icono: UIImage){
        minutLabel.text = "\(minuto)'"
        minutLabel.textColor = .white
    
        detailsLabel.textColor = .white
        detailsLabel.text = nombre
        iconImage.image = icono
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
