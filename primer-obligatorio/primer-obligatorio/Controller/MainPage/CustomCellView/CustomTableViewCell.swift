//
//  CustomTableViewCell.swift
//  primer-obligatorio
//
//  Created by Manuela Garcia Lira on 1/5/23.
//

import UIKit

class CustomTableViewCell: UITableViewCell {
    
    static let reuseIdentifier :String = "CustomTableViewCell"
    
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
    var actualGame: Game?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Initialization default and generic colors and details
        self.backgroundColor = blueBackgroundTableView
        //header view
        headerCellView.backgroundColor = blueBackgroundTableView
        // result view
        cardPrincipalView.backgroundColor = blueBackgroundTableView
        gameResultView.backgroundColor = blueBackgroundTableView
        firstRivalResultText.backgroundColor = blueBackgroundTableView
        secondRivalResultText.backgroundColor = blueBackgroundTableView
        myContentView.layer.borderColor = lightBlueTableViewDetails.cgColor
        myContentView.layer.borderWidth = 1.0
        // delegate for result text fields and keyboard
        firstRivalResultText.delegate = self
        secondRivalResultText.delegate = self
        firstRivalResultText.keyboardType = .numberPad
        secondRivalResultText.keyboardType = .numberPad
        // footer view
        buttonView.backgroundColor = blueBackgroundTableView
        buttonView.layer.borderColor = lightBlueTableViewDetails.cgColor
        buttonView.layer.borderWidth = 1.0
        moreDetailsButton.tintColor = .white
    }
    
    func changeColors(primaryColor: UIColor, secundaryColor: UIColor, detailsColor: UIColor, game: Game){
        // header card
        headerCellView.backgroundColor = primaryColor
        headerLabel.backgroundColor = secundaryColor
        headerLabel.layer.cornerRadius = 3.0
        headerLabel.clipsToBounds = true
        
        // basic style for cell
        firstRivalResultText.textColor = .white
        secondRivalResultText.textColor = .white
        
        firstRivalImage.image = game.localTeam.imageTeam
        firstRivalLabel.text = game.localTeam.nameTeam
        secondRivalImage.image = game.rivalTeam.imageTeam
        secondRivalLabel.text = game.rivalTeam.nameTeam
        
        firstRivalResultText.text = String(game.homeTeamGoals)
        secondRivalResultText.text = String(game.awayTeamGoals)
        firstRivalResultText.isEnabled = false
        secondRivalResultText.isEnabled = false
        firstRivalResultText.backgroundColor = blueBackgroundTableView
        secondRivalResultText.backgroundColor = blueBackgroundTableView
        gameResultView.backgroundColor = blueBackgroundTableView
        gameResultView.layer.borderColor = lightBlueTableViewDetails.cgColor
        gameResultView.layer.backgroundColor = blueBackgroundTableView.cgColor
        gameResultView.layer.borderWidth = 1.0
        gameResultView.layer.cornerRadius = 10.0
        cardPrincipalView.backgroundColor = blueBackgroundTableView
        
        // button in footer
        moreDetailsButton.isHidden = false
        buttonView.layer.borderColor = detailsColor.cgColor
        buttonView.backgroundColor = blueBackgroundTableView
        buttonView.layer.borderColor = lightBlueTableViewDetails.cgColor
        buttonView.layer.borderWidth = 1.0
        
        switch(game.status) {
            
        case .acertado:
            headerLabel.text = " Acertado "
        case .errado:
            headerLabel.text = " Errado "
        case .jugado:
            firstRivalResultText.text = "-"
            secondRivalResultText.text = "-"
            headerLabel.text = " Jugado sin resultados "
        case .pendiente:
            headerLabel.text = " Pendiente "
            // pongo el color de fondo para la card result diferente al resto
            firstRivalResultText.backgroundColor = blueBackgroundPickerCard
            secondRivalResultText.backgroundColor = blueBackgroundPickerCard
            firstRivalResultText.isEnabled = true
            secondRivalResultText.isEnabled = true
            moreDetailsButton.isHidden = true
            cardPrincipalView.backgroundColor = blueBackgroundViewPendingCard
            buttonView.backgroundColor = blueBackgroundViewPendingCard
            buttonView.layer.borderColor = blueBackgroundViewPendingCard.cgColor
            buttonView.layer.borderWidth = 0
            
            firstRivalResultText.text = "-"
            secondRivalResultText.text = "-"
            //fixme: update data
            //firstRivalResultText.text = String(partido.homeTeamGoals)
            //secondRivalResultText.text = String(partido.awayTeamGoals)
        }
    }
    
    func setup(partido: Game){
        switch(partido.status) {
        case .acertado:
            changeColors(primaryColor: greenBackgroundCard, secundaryColor: greenBackgroundLabelCard, detailsColor: lightBlueTableViewDetails, game: partido)
        case .jugado:
            changeColors(primaryColor: greyBackgroundCard, secundaryColor: greyBackgroundLabelCard, detailsColor: lightBlueTableViewDetails, game: partido)
        case .errado:
            changeColors(primaryColor: redBackgroundCard, secundaryColor: redBackgroundLabelCard, detailsColor: lightBlueTableViewDetails, game: partido)
        case .pendiente:
            changeColors(primaryColor: blueBackgroundCard, secundaryColor: blueBackgroundLabelCard, detailsColor: lightBlueTableViewDetails, game: partido)
        }
    }
    
    @objc func customTableViewCellDidTapButton(_ sender: UIButton) {
        delegate?.customTableViewCellDidTapButton(with: actualGame)
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
    
    // al momento de ingresar caracteres hace la validacion para poder permitir solo numeros entre el 0 y el 99 y cuando los resultados fueron modificados, entonces establecerlos como finales
    // fixme: no deberia ser estado final solo deberia guardarse
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
