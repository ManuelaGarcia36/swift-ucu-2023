//
//  DetailsPartidoViewController.swift
//  primer-obligatorio
//
//  Created by Manuela Garcia Lira on 4/5/23.
//

import Foundation
import UIKit

class DetailsPartidoViewController: UIViewController {
    
    // first sub view
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
    
    var partidoActual: Partido?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    func setup(){
        if let partido = partidoActual {
            switch (partido.status){
            case .acertado:
                statusGameView.backgroundColor = greenBackgroundCard
                statusLabel.backgroundColor = greenBackgroundLabelCard
                dateLabel.textColor = .white
                statusLabel.textColor = .white
                statusLabel.text = " Acertado "
                statusLabel.layer.cornerRadius = 5.0
                statusLabel.clipsToBounds = true
                dateLabel.text = Date.dateFromToCustomString(date: partido.dateGame ?? Date())
            case .errado:
                statusGameView.backgroundColor = redBackgroundCard
                statusLabel.backgroundColor = redBackgroundLabelCard
                dateLabel.textColor = .white
                statusLabel.textColor = .white
                statusLabel.text = " Errado "
                statusLabel.layer.cornerRadius = 5.0
                statusLabel.clipsToBounds = true
                dateLabel.text = Date.dateFromToCustomString(date: partido.dateGame ?? Date())
            case .jugado:
                statusGameView.backgroundColor = greyBackgroundCard
                statusLabel.backgroundColor = greyBackgroundLabelCard
                dateLabel.textColor = .white
                statusLabel.textColor = .white
                statusLabel.text = " Jugado sin/resulados"
                statusLabel.layer.cornerRadius = 5.0
                statusLabel.clipsToBounds = true
                dateLabel.text = Date.dateFromToCustomString(date: partido.dateGame ?? Date())
            case .pendiente:
                break;
            }
            
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
