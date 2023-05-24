//
//  EmptyTableViewCell.swift
//  primer-obligatorio
//
//  Created by Manuela Garcia Lira on 15/5/23.
//

import UIKit

class EmptyTableViewCell: UITableViewCell {
    
    static let identifier = "EmptyTableViewCell"
    
    static func nib() -> UINib {
        return UINib(nibName: self.identifier, bundle: nil)
    }
    
    @IBOutlet weak var messageLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setup(message: String){
        messageLabel.text = message
        messageLabel.textColor = .white
        backgroundColor = UIColor.blueBackgroundTableView
    }
}
