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
    
    var matchSelected: MatchResponse?
    var matchDetails: MatchDetailResponse?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        
        detailsTableView.register(FirstTableViewCell.nib(), forCellReuseIdentifier: FirstTableViewCell.identifier)
        detailsTableView.register(RivalTableViewCell.nib(), forCellReuseIdentifier: RivalTableViewCell.identifier)
        detailsTableView.delegate = self
        detailsTableView.dataSource = self
        
        contentView.backgroundColor = UIColor.blueBackgroundTableView
        detailsTableView.backgroundColor = UIColor.blueBackgroundTableView
        
        // commons
        dateLabel.textColor = .white
        statusLabel.textColor = .white
        statusLabel.layer.cornerRadius = 5.0
        statusLabel.clipsToBounds = true
        
    }
    
    func setup(){
        if let game = matchSelected {
            switch (game.status){
            case .correct:
                statusGameView.backgroundColor = UIColor.greenBackgroundCard
                statusLabel.backgroundColor = UIColor.greenBackgroundLabelCard
                statusLabel.text = " Acertado "
            case .incorrect:
                statusGameView.backgroundColor = UIColor.redBackgroundCard
                statusLabel.backgroundColor = UIColor.redBackgroundLabelCard
                statusLabel.text = " Errado "
            case .not_predicted:
                statusGameView.backgroundColor = UIColor.greyBackgroundCard
                statusLabel.backgroundColor = UIColor.greyBackgroundLabelCard
                statusLabel.text = " Jugado sin/resulados"
            case .pending:
                break;
            }
            if let details = matchDetails {
                dateLabel.text = Date.dateFromToCustomString(date: details.date)
                
                let url = URL(string: "https://\(details.homeTeamLogo)")
                firstRivalImage.kf.setImage(with: url!)
                
                firstRivalNameLabel.text = details.homeTeamName
                firstRivalNameLabel.textColor = .white
                
                let url2 = URL(string: "https://\(details.awayTeamLogo)")
                secondRivalImage.kf.setImage(with: url2!)
               
                secondRivalLabel.text = details.awayTeamName
                secondRivalLabel.textColor = .white
                
                resultGameLabel.text = "\(details.homeTeamGoals) - \(details.awayTeamGoals)"
                resultGameView.backgroundColor = UIColor.lightBlueTableViewDetails
                resultGameLabel.textColor = .white
            }
        }
    }
}

extension DetailsGameViewController: UITableViewDelegate {
    
}

extension DetailsGameViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let details = matchDetails {
            return details.incidences.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let game = matchDetails {
            
            let sortedObservations =  game.incidences.sorted { $0.minute < $1.minute }
            let observation = sortedObservations[indexPath.row]
            
            if observation.side == "home" {
                guard let cell = tableView.dequeueReusableCell(withIdentifier: FirstTableViewCell.identifier, for: indexPath) as? FirstTableViewCell
                else { return .init()}
                let nombreImage = "\(observation.event)"
                let image =  UIImage(named: nombreImage)!
                cell.setup(minuto: observation.minute, nombre: observation.playerName, icono: image)
                return cell
            } else if observation.side == "away" {
                guard let cell = tableView.dequeueReusableCell(withIdentifier: RivalTableViewCell.identifier, for: indexPath) as? RivalTableViewCell
                else { return .init()}
                let image =  UIImage(named: "\(observation.event)")!
                cell.setup(minuto: observation.minute, nombre: observation.playerName, icono: image)
                return cell
            }
        }
        return UITableViewCell()
    }
}

