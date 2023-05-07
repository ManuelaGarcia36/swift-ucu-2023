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
       // FIXME: partidoActual = partido
    }
    
    func setUp(partido: Partido){
        
        partidoActual = partido
        switch (partido.estado){
        case .acertado:
            statusGameView.backgroundColor = greenBackgroundCard
            statusLabel.backgroundColor = greenBackgroundLabelCard
            statusLabel.text = " Acertado "
        case .errado:
            
            statusGameView.backgroundColor = greenBackgroundCard
            statusLabel.backgroundColor = greenBackgroundLabelCard
            statusLabel.text = " Acertado "
        case .jugado:
            statusGameView.backgroundColor = greyBackgroundCard
            statusLabel.backgroundColor = greyBackgroundLabelCard
            statusLabel.text = " Jugado sin datos "
        case .pendiente:
            break;
        }
        
        firstRivalImage.image = partido.equipoLocal.imagen
        firstRivalNameLabel.text = partido.equipoLocal.nombre
        secondRivalImage.image = partido.equipoVisitante.imagen
        secondRivalLabel.text = partido.equipoVisitante.nombre
        
        resultGameLabel.text = "\(partido.golesLocal) - \(partido.golesVisitante)"
        
        
    }
    
}
