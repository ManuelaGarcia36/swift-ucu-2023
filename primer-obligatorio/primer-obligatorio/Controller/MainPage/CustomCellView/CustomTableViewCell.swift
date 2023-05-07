//
//  CustomTableViewCell.swift
//  primer-obligatorio
//
//  Created by Manuela Garcia Lira on 1/5/23.
//

import UIKit

class CustomTableViewCell: UITableViewCell {
    
    // Vistas mas grandes
    @IBOutlet weak var myContentView: UIView!
    @IBOutlet weak var headerCellView: UIView!
    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var cardPrincipalView: UIView!
    @IBOutlet weak var gameResultView: UIView!
    
    // components
    @IBOutlet weak var firstRivalImage: UIImageView!
    @IBOutlet weak var secondRivalImage: UIImageView!
    @IBOutlet weak var firstRivalLabel: UILabel!
    @IBOutlet weak var secondRivalLabel: UILabel!
    
    // Result
    @IBOutlet weak var firstRivalResultText: UITextField!
    @IBOutlet weak var secondRivalResultText: UITextField!
    
    // Button
    @IBOutlet weak var moreDetailsButton: UIButton!
    @IBOutlet weak var buttonView: UIView!
    
    weak var delegate: CustomTableViewCellDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()
        
       
        // Initialization default and generic colors and details
        self.backgroundColor = blueBackgroundTableView
        headerCellView.backgroundColor = blueBackgroundTableView
        cardPrincipalView.backgroundColor = blueBackgroundTableView
        buttonView.backgroundColor = blueBackgroundTableView
        gameResultView.backgroundColor = blueBackgroundTableView
        firstRivalResultText.backgroundColor = blueBackgroundTableView
        secondRivalResultText.backgroundColor = blueBackgroundTableView
        // Configurar el borde de la vista
        myContentView.layer.borderColor = lightBlueTableViewDetails.cgColor
        myContentView.layer.borderWidth = 1.0
        buttonView.layer.borderColor = lightBlueTableViewDetails.cgColor
        buttonView.layer.borderWidth = 1.0
        
        moreDetailsButton.tintColor = .white
        
        firstRivalResultText.delegate = self
        secondRivalResultText.delegate = self
        firstRivalResultText.keyboardType = .numberPad
        secondRivalResultText.keyboardType = .numberPad
        
    }
    
    func setup(partido: Partido){
   
        switch(partido.estado) {
        case .acertado:
            // FIXME: Generalizar logica y mejorarla
            headerCellView.backgroundColor = greenBackgroundCard
            headerLabel.backgroundColor = greenBackgroundLabelCard
            headerLabel.text = " Acertado "
            firstRivalResultText.isEnabled = false
            secondRivalResultText.isEnabled = false
            firstRivalResultText.text = String(partido.golesLocal)
            secondRivalResultText.text = String(partido.golesVisitante)
            
        case .jugado:
            headerCellView.backgroundColor = greyBackgroundCard
            headerLabel.backgroundColor = greyBackgroundLabelCard
            headerLabel.text = " Jugado s/resultado "
            firstRivalResultText.isEnabled = false
            secondRivalResultText.isEnabled = false
            
            firstRivalResultText.text = "-"
            secondRivalResultText.text = "-"
            
        case .errado:
            headerCellView.backgroundColor = redBackgroundCard
            headerLabel.backgroundColor = redBackgroundLabelCard
            headerLabel.text = " Errado "
            
            firstRivalResultText.isEnabled = false
            secondRivalResultText.isEnabled = false
            
            firstRivalResultText.text = String(partido.golesLocal)
            secondRivalResultText.text = String(partido.golesVisitante)
            
        case .pendiente:
            headerCellView.backgroundColor = blueBackgroundCard
            headerLabel.backgroundColor = blueBackgroundLabelCard
            headerLabel.text = " Pendiente "
            
            moreDetailsButton.isHidden = true
            
            
            // dar fondo a picker
            gameResultView.backgroundColor = blueBackgroundPickerCard
            // borde
            gameResultView.layer.borderColor = lightBlueTableViewDetails.cgColor
            gameResultView.layer.borderWidth = 1.0
            gameResultView.layer.cornerRadius = 10.0
            
            firstRivalResultText.backgroundColor = blueBackgroundPickerCard
            
            secondRivalResultText.backgroundColor = blueBackgroundPickerCard
            firstRivalResultText.isEnabled = true
            secondRivalResultText.isEnabled = true
            
            cardPrincipalView.backgroundColor = blueBackgroundViewPendingCard
            buttonView.backgroundColor = blueBackgroundViewPendingCard
            buttonView.layer.borderColor = blueBackgroundViewPendingCard.cgColor
            buttonView.layer.borderWidth = 0
            
            //fixme:
            firstRivalResultText.text = String(partido.golesLocal)
            secondRivalResultText.text = String(partido.golesVisitante)
            
        }
        
        // common
        headerLabel.layer.cornerRadius = 3.0
        headerLabel.clipsToBounds = true
        
        firstRivalResultText.textColor = .white
        secondRivalResultText.textColor = .white
        
        
        firstRivalImage.image = partido.equipoLocal.imagen
        firstRivalLabel.text = partido.equipoLocal.nombre
        
        secondRivalImage.image = partido.equipoVisitante.imagen
        secondRivalLabel.text = partido.equipoVisitante.nombre
    }
    
    @objc func buttonPressed(_ sender: UIButton) {
        delegate?.customTableViewCellDidTapButton(self)
    }
    
}

protocol CustomTableViewCellDelegate: AnyObject {
    func customTableViewCellDidTapButton(_ cell: CustomTableViewCell)
}
