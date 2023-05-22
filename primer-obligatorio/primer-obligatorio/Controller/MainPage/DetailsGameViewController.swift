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
    
    // details sub view
    @IBOutlet weak var detailsTableView: UITableView!
    var actualGame: Game?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        
        detailsTableView.register(FirstTableViewCell.nib(), forCellReuseIdentifier: FirstTableViewCell.identifier)
        detailsTableView.register(RivalTableViewCell.nib(), forCellReuseIdentifier: RivalTableViewCell.identifier)
        detailsTableView.delegate = self
        detailsTableView.dataSource = self
        
    }
    
    func setup(){
        contentView.backgroundColor = UIColor.blueBackgroundTableView
        detailsTableView.backgroundColor = UIColor.blueBackgroundTableView
        if let partido = actualGame {
            switch (partido.status){
            case .acertado:
                statusGameView.backgroundColor = UIColor.greenBackgroundCard
                statusLabel.backgroundColor = UIColor.greenBackgroundLabelCard
                statusLabel.text = " Acertado "
            case .errado:
                statusGameView.backgroundColor = UIColor.redBackgroundCard
                statusLabel.backgroundColor = UIColor.redBackgroundLabelCard
                statusLabel.text = " Errado "
            case .jugado:
                statusGameView.backgroundColor = UIColor.greyBackgroundCard
                statusLabel.backgroundColor = UIColor.greyBackgroundLabelCard
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
            resultGameView.backgroundColor = UIColor.lightBlueTableViewDetails
            resultGameLabel.textColor = .white
        }
    }
}

extension DetailsGameViewController: UITableViewDelegate {
    
}

extension DetailsGameViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return actualGame?.observations.count  ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let game = actualGame {
            
            let sortedObservations =  game.observations.sorted { $0.minuto < $1.minuto }
            let observation = sortedObservations[indexPath.row]
            
            if observation.equipo == "local" {
                guard let cell = tableView.dequeueReusableCell(withIdentifier: FirstTableViewCell.identifier, for: indexPath) as? FirstTableViewCell
                else { return .init()}
                let nombreImage = "\(observation.tipo)"
                let image =  UIImage(named: nombreImage) ?? UIImage()
                cell.setup(minuto: observation.minuto, nombre: observation.nombre, icono: image)
                return cell
            } else if observation.equipo == "visitante" {
                guard let cell = tableView.dequeueReusableCell(withIdentifier: RivalTableViewCell.identifier, for: indexPath) as? RivalTableViewCell
                else { return .init()}
                let image =  UIImage(named: "\(observation.tipo)") ?? UIImage()
                cell.setup(minuto: observation.minuto, nombre: observation.nombre, icono: image)
                return cell
            }
        }
        return UITableViewCell()
    }
}

