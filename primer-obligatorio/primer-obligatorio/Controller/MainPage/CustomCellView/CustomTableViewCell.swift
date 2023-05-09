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
    var partidoActual: Game?
    
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
    
    func setup(partido: Game){
        switch(partido.status) {
        case .acertado:
            // FIXME: Generalizar logica y mejorarla
            headerCellView.backgroundColor = greenBackgroundCard
            headerLabel.backgroundColor = greenBackgroundLabelCard
            headerLabel.text = " Acertado "
            // fixme
            firstRivalResultText.text = String(partido.homeTeamGoals)
            secondRivalResultText.text = String(partido.awayTeamGoals)
            firstRivalResultText.isEnabled = false
            secondRivalResultText.isEnabled = false
            
            moreDetailsButton.isHidden = false
            buttonView.layer.borderColor = lightBlueTableViewDetails.cgColor
            
            // dar fondo a picker
            gameResultView.backgroundColor = blueBackgroundTableView
            // borde
            gameResultView.layer.borderColor = lightBlueTableViewDetails.cgColor
            gameResultView.layer.borderWidth = 1.0
            gameResultView.layer.cornerRadius = 10.0
            gameResultView.layer.backgroundColor = blueBackgroundTableView.cgColor
            
            firstRivalResultText.backgroundColor = blueBackgroundTableView
            secondRivalResultText.backgroundColor = blueBackgroundTableView
            
            firstRivalResultText.isEnabled = false
            secondRivalResultText.isEnabled = false
            
            cardPrincipalView.backgroundColor = blueBackgroundTableView
            buttonView.backgroundColor = blueBackgroundTableView
            
        case .jugado:
            headerCellView.backgroundColor = greyBackgroundCard
            headerLabel.backgroundColor = greyBackgroundLabelCard
            headerLabel.text = " Jugado s/resultado "
            firstRivalResultText.isEnabled = false
            secondRivalResultText.isEnabled = false
            
            firstRivalResultText.text = "-"
            secondRivalResultText.text = "-"
            
            moreDetailsButton.isHidden = false
            buttonView.layer.borderColor = lightBlueTableViewDetails.cgColor
            
            // dar fondo a picker
            gameResultView.backgroundColor = blueBackgroundTableView
            // borde
            gameResultView.layer.borderColor = lightBlueTableViewDetails.cgColor
            gameResultView.layer.borderWidth = 1.0
            gameResultView.layer.cornerRadius = 10.0
            gameResultView.layer.backgroundColor = blueBackgroundTableView.cgColor
            
            firstRivalResultText.backgroundColor = blueBackgroundTableView
            secondRivalResultText.backgroundColor = blueBackgroundTableView
            
            firstRivalResultText.isEnabled = false
            secondRivalResultText.isEnabled = false
            
            cardPrincipalView.backgroundColor = blueBackgroundTableView
            buttonView.backgroundColor = blueBackgroundTableView
            
            //fixme: mejorar
            firstRivalResultText.text = String(partido.homeTeamGoals)
            secondRivalResultText.text = String(partido.awayTeamGoals)
            
        case .errado:
            headerCellView.backgroundColor = redBackgroundCard
            headerLabel.backgroundColor = redBackgroundLabelCard
            headerLabel.text = " Errado "
            
            firstRivalResultText.isEnabled = false
            secondRivalResultText.isEnabled = false
            
            // fixme
            firstRivalResultText.text = String(partido.homeTeamGoals)
            secondRivalResultText.text = String(partido.awayTeamGoals)
            
            moreDetailsButton.isHidden = false
            buttonView.layer.borderColor = lightBlueTableViewDetails.cgColor
            // dar fondo a picker
            gameResultView.backgroundColor = blueBackgroundTableView
            // borde
            gameResultView.layer.borderColor = lightBlueTableViewDetails.cgColor
            gameResultView.layer.borderWidth = 1.0
            gameResultView.layer.cornerRadius = 10.0
            gameResultView.layer.backgroundColor = blueBackgroundTableView.cgColor
            
            firstRivalResultText.backgroundColor = blueBackgroundTableView
            secondRivalResultText.backgroundColor = blueBackgroundTableView
            
            firstRivalResultText.isEnabled = false
            secondRivalResultText.isEnabled = false
            
            cardPrincipalView.backgroundColor = blueBackgroundTableView
            buttonView.backgroundColor = blueBackgroundTableView
            
            
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
            
            firstRivalResultText.text = "-"
            secondRivalResultText.text = "-"
            
            //fixme:
            //firstRivalResultText.text = String(partido.homeTeamGoals)
            //secondRivalResultText.text = String(partido.awayTeamGoals)
            
        }
        
        // common
        headerLabel.layer.cornerRadius = 3.0
        headerLabel.clipsToBounds = true
        
        firstRivalResultText.textColor = .white
        secondRivalResultText.textColor = .white
        
        
        firstRivalImage.image = partido.localTeam.imageTeam
        firstRivalLabel.text = partido.localTeam.nameTeam
        
        secondRivalImage.image = partido.rivalTeam.imageTeam
        secondRivalLabel.text = partido.rivalTeam.nameTeam
    }
    
    @objc func customTableViewCellDidTapButton(_ sender: UIButton) {
        delegate?.customTableViewCellDidTapButton(with: partidoActual)
    }
    
    func updateViewResult() {
        if (firstRivalResultText.text != "-" && secondRivalResultText.text != "-") {
            firstRivalResultText.backgroundColor = blueBackgroundTableView
            secondRivalResultText.backgroundColor = blueBackgroundTableView
            
            firstRivalResultText.isEnabled = false
            secondRivalResultText.isEnabled = false
        }
    }
}

protocol CustomTableViewCellDelegate: AnyObject {
    func customTableViewCellDidTapButton(with partido: Game?)
}

extension CustomTableViewCell: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let allowedCharacters = CharacterSet.decimalDigits
        let characterSet = CharacterSet(charactersIn: string)
        
        guard allowedCharacters.isSuperset(of: characterSet) else {
            return false
        }
        let currentText = (textField.text ?? "") as NSString
        let updatedText = currentText.replacingCharacters(in: range, with: string)
        
        // Verificar si el valor es menor que 99 y 0
        if let number = Int(updatedText), number < 100 && number >= 0 {
            if textField == firstRivalResultText {
                firstRivalResultText.text = updatedText
            } else if textField == secondRivalResultText {
                secondRivalResultText.text = updatedText
            }
            updateViewResult()
            return true
        }
        
        return false
    }
    
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.text = ""
    }
    
}
