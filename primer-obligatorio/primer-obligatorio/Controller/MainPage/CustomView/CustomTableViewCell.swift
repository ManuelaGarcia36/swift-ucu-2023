//
//  CustomTableViewCell.swift
//  primer-obligatorio
//
//  Created by Manuela Garcia Lira on 1/5/23.
//

import UIKit

class CustomTableViewCell: UITableViewCell {
    
    // Views
    @IBOutlet weak var myContentView: UIView!
    @IBOutlet weak var headerCellView: UIView!
    @IBOutlet weak var headerLabel: UILabel!
    
    @IBOutlet weak var cardPartyView: UIView!

    @IBOutlet weak var buttonCellView: UIView!
    
    @IBOutlet weak var paryResultView: UIView!
    // Images and names
    @IBOutlet weak var primerRivalImage: UIImageView!
    @IBOutlet weak var segundoRivalImage: UIImageView!
    @IBOutlet weak var primerRivalLabel: UILabel!
    @IBOutlet weak var segundoRivalLabel: UILabel!
    
    // Texts
    @IBOutlet weak var primerRivalResultText: UITextField!
    @IBOutlet weak var segundoRivalResultText: UITextField!
    
    // Button
    @IBOutlet weak var moreDetailsButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Initialization default and generic colors and details
        self.backgroundColor = blueBackgroundTableView
        headerCellView.backgroundColor = blueBackgroundTableView
        cardPartyView.backgroundColor = blueBackgroundTableView
        buttonCellView.backgroundColor = blueBackgroundTableView
        paryResultView.backgroundColor = blueBackgroundTableView
        primerRivalResultText.backgroundColor = blueBackgroundTableView
        segundoRivalResultText.backgroundColor = blueBackgroundTableView
        // Configurar el borde de la vista
        myContentView.layer.borderColor = lightBlueTableViewDetails.cgColor
        myContentView.layer.borderWidth = 1.0
        buttonCellView.layer.borderColor = lightBlueTableViewDetails.cgColor
        buttonCellView.layer.borderWidth = 1.0
    
        moreDetailsButton.tintColor = .white
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setup(partido: Partido){
        
        switch(partido.estado) {
        case .acertado:
            
            headerCellView.backgroundColor = greenBackgroundCard
            headerLabel.backgroundColor = greenBackgroundLabelCard
            headerLabel.text = " Acertado "
            primerRivalResultText.isEnabled = false
            segundoRivalResultText.isEnabled = false
            primerRivalResultText.text = String(partido.golesLocal)
            segundoRivalResultText.text = String(partido.golesVisitante)
            
        case .jugado:
            headerCellView.backgroundColor = greyBackgroundCard
            headerLabel.backgroundColor = greyBackgroundLabelCard
            headerLabel.text = " Jugado s/resultado "
            primerRivalResultText.isEnabled = false
            segundoRivalResultText.isEnabled = false
            
            primerRivalResultText.text = "-"
            segundoRivalResultText.text = "-"
            
        case .noAcertado:
            headerCellView.backgroundColor = redBackgroundCard
            headerLabel.backgroundColor = redBackgroundLabelCard
            headerLabel.text = " Errado "
            
            primerRivalResultText.isEnabled = false
            segundoRivalResultText.isEnabled = false
            
            primerRivalResultText.text = String(partido.golesLocal)
            segundoRivalResultText.text = String(partido.golesVisitante)
            
        case .pendiente:
            headerCellView.backgroundColor = blueBackgroundCard
            headerLabel.backgroundColor = blueBackgroundLabelCard
            headerLabel.text = " Pendiente "
            
            moreDetailsButton.isHidden = true
           
            
            // dar fondo a picker
            paryResultView.backgroundColor = blueBackgroundPickerCard
            // borde
            paryResultView.layer.borderColor = lightBlueTableViewDetails.cgColor
            paryResultView.layer.borderWidth = 1.0
            paryResultView.layer.cornerRadius = 10.0
            
            primerRivalResultText.backgroundColor = blueBackgroundPickerCard
        
            segundoRivalResultText.backgroundColor = blueBackgroundPickerCard
            primerRivalResultText.isEnabled = true
            segundoRivalResultText.isEnabled = true
            
            cardPartyView.backgroundColor = blueBackgroundViewPendingCard
            buttonCellView.backgroundColor = blueBackgroundViewPendingCard
            buttonCellView.layer.borderColor = blueBackgroundViewPendingCard.cgColor
            buttonCellView.layer.borderWidth = 0
            
            //fixme:
            primerRivalResultText.text = String(partido.golesLocal)
            segundoRivalResultText.text = String(partido.golesVisitante)
        
        }
        
        // common
        headerLabel.layer.cornerRadius = 3.0
        headerLabel.clipsToBounds = true
        
        primerRivalResultText.textColor = .white
        segundoRivalResultText.textColor = .white
        
        
        primerRivalImage.image = partido.equipoLocal.imagen
        primerRivalLabel.text = partido.equipoLocal.nombre
        
        segundoRivalImage.image = partido.equipoVisitante.imagen
        segundoRivalLabel.text = partido.equipoVisitante.nombre
    }
    
}

