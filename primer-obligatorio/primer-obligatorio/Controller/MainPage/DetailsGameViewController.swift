//
//  DetailsPartidoViewController.swift
//  primer-obligatorio
//
//  Created by Manuela Garcia Lira on 4/5/23.
//

import Foundation
import UIKit

// MiniDetails
class DetailsGameViewController: UIViewController {
    
    // first sub view
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var statusGameView: UIView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    
    // second sub view
    @IBOutlet weak var resultGameView: UIView!
    @IBOutlet weak var firstRivalImage: UIImageView!
    @IBOutlet weak var firstRivalNameLabel: UILabel!
    @IBOutlet weak var resultGameLabel: UILabel!
    @IBOutlet weak var secondRivalImage: UIImageView!
    @IBOutlet weak var secondRivalLabel: UILabel!
    
    var actualGame: Game?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    func setup(){
        contentView.backgroundColor = blueBackgroundTableView
        if let partido = actualGame {
            switch (partido.status){
            case .acertado:
                statusGameView.backgroundColor = greenBackgroundCard
                statusLabel.backgroundColor = greenBackgroundLabelCard
                statusLabel.text = " Acertado "
            case .errado:
                statusGameView.backgroundColor = redBackgroundCard
                statusLabel.backgroundColor = redBackgroundLabelCard
                statusLabel.text = " Errado "
            case .jugado:
                statusGameView.backgroundColor = greyBackgroundCard
                statusLabel.backgroundColor = greyBackgroundLabelCard
                statusLabel.text = " Jugado sin/resulados"
            case .pendiente:
                break;
            }
            // commons
            dateLabel.textColor = .white
            statusLabel.textColor = .white
            statusLabel.layer.cornerRadius = 5.0
            statusLabel.clipsToBounds = true
            dateLabel.text = Date.dateFromToCustomString(date: partido.dateGame ?? Date())
            firstRivalImage.image = partido.localTeam.imageTeam
            firstRivalNameLabel.text = partido.localTeam.nameTeam
            firstRivalNameLabel.textColor = .white
            secondRivalImage.image = partido.rivalTeam.imageTeam
            secondRivalLabel.text = partido.rivalTeam.nameTeam
            secondRivalLabel.textColor = .white
            resultGameLabel.text = "\(partido.homeTeamGoals) - \(partido.awayTeamGoals)"
            resultGameView.backgroundColor = lightBlueTableViewDetails
            resultGameLabel.textColor = .white
        }
    }
}
