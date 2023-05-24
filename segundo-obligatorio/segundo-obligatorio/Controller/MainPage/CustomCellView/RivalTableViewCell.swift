//
//  SecondTableViewCell.swift
//  primer-obligatorio
//
//  Created by Manuela Garcia Lira on 15/5/23.
//

import UIKit

class RivalTableViewCell: UITableViewCell {

    static let identifier = "RivalTableViewCell"
    
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
       // minutLabel.text = "103'"
        minutLabel.text = "\(minuto)'"
        minutLabel.textColor = .white
        
       // detailLabel.text = "Sebastian cabrera martinez"
        detailLabel.textColor = .white
        detailLabel.text = nombre
        iconImage.image = icono
        //iconImage.image = UIImage(named: "amarilla")
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
