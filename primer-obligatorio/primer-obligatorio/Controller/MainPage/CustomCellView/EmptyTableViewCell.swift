//
//  EmptyTableViewCell.swift
//  primer-obligatorio
//
//  Created by Manuela Garcia Lira on 15/5/23.
//

import UIKit

class EmptyTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var messageLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setup(message: String){
        messageLabel.text = message
        messageLabel.textColor = .white
        backgroundColor = blueBackgroundTableView
    }
}
