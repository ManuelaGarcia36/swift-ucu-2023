//
//  CustomTableViewCell.swift
//  primer-obligatorio
//
//  Created by Manuela Garcia Lira on 1/5/23.
//

import UIKit

class CustomTableViewCell: UITableViewCell {
    
    static let reuseIdentifier :String = "CustomTableViewCell"
    
    static func nib() -> UINib {
        return UINib(nibName: self.reuseIdentifier, bundle: nil)
    }
    
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
    
    // opcional en caso de que no la tengamos
    weak var delegate: CustomTableViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Initialization default and generic colors and details
        self.backgroundColor = UIColor.blueBackgroundTableView
        //header view
        headerCellView.backgroundColor = UIColor.blueBackgroundTableView
        // result view
        cardPrincipalView.backgroundColor = UIColor.blueBackgroundTableView
        gameResultView.backgroundColor = UIColor.blueBackgroundTableView
        firstRivalResultText.backgroundColor = UIColor.blueBackgroundTableView
        secondRivalResultText.backgroundColor = UIColor.blueBackgroundTableView
        myContentView.layer.borderColor = UIColor.lightBlueTableViewDetails.cgColor
        myContentView.layer.borderWidth = 1.0
        // delegate for result text fields and keyboard
        firstRivalResultText.delegate = self
        secondRivalResultText.delegate = self
        firstRivalResultText.keyboardType = .numberPad
        secondRivalResultText.keyboardType = .numberPad
        // footer view
        buttonView.backgroundColor = UIColor.blueBackgroundTableView
        buttonView.layer.borderColor = UIColor.lightBlueTableViewDetails.cgColor
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
        firstRivalResultText.backgroundColor = UIColor.blueBackgroundTableView
        secondRivalResultText.backgroundColor = UIColor.blueBackgroundTableView
        gameResultView.backgroundColor = UIColor.blueBackgroundTableView
        gameResultView.layer.borderColor = UIColor.lightBlueTableViewDetails.cgColor
        gameResultView.layer.backgroundColor = UIColor.blueBackgroundTableView.cgColor
        gameResultView.layer.borderWidth = 1.0
        gameResultView.layer.cornerRadius = 10.0
        cardPrincipalView.backgroundColor = UIColor.blueBackgroundTableView
        
        // button in footer
        moreDetailsButton.isHidden = false
        buttonView.layer.borderColor = detailsColor.cgColor
        buttonView.backgroundColor = UIColor.blueBackgroundTableView
        buttonView.layer.borderColor = UIColor.lightBlueTableViewDetails.cgColor
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
            firstRivalResultText.backgroundColor = UIColor.blueBackgroundPickerCard
            secondRivalResultText.backgroundColor = UIColor.blueBackgroundPickerCard
            firstRivalResultText.isEnabled = true
            secondRivalResultText.isEnabled = true
            moreDetailsButton.isHidden = true
            cardPrincipalView.backgroundColor = UIColor.blueBackgroundViewPendingCard
            buttonView.backgroundColor = UIColor.blueBackgroundViewPendingCard
            buttonView.layer.borderColor = UIColor.blueBackgroundViewPendingCard.cgColor
            buttonView.layer.borderWidth = 0
        }
    }
    
    func setup(partido: Game){
        switch(partido.status) {
        case .acertado:
            changeColors(primaryColor: UIColor.greenBackgroundCard, secundaryColor: UIColor.greenBackgroundLabelCard, detailsColor: UIColor.lightBlueTableViewDetails, game: partido)
        case .jugado:
            changeColors(primaryColor: UIColor.greyBackgroundCard, secundaryColor: UIColor.greyBackgroundLabelCard, detailsColor: UIColor.lightBlueTableViewDetails, game: partido)
        case .errado:
            changeColors(primaryColor: UIColor.redBackgroundCard, secundaryColor: UIColor.redBackgroundLabelCard, detailsColor: UIColor.lightBlueTableViewDetails, game: partido)
        case .pendiente:
            changeColors(primaryColor: UIColor.blueBackgroundCard, secundaryColor: UIColor.blueBackgroundLabelCard, detailsColor: UIColor.lightBlueTableViewDetails, game: partido)
        }
    }
    
    @IBAction func moreDetailsTaped(_ sender: UIButton) {
        delegate?.didSelectedTheButton(tag)
    }
    
    func updateResults() {
        let firstResult = Int(firstRivalResultText.text ?? "") ?? 0
        let secondResult = Int(secondRivalResultText.text ?? "") ?? 0
        delegate?.updateResultGame(tag, goalLocal: firstResult, goalVisit: secondResult)
    }
}

protocol CustomTableViewCellDelegate: AnyObject{
    func didSelectedTheButton(_ index: Int)
    
    func updateResultGame(_ index: Int, goalLocal: Int, goalVisit: Int)
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
        print(currentText)
        print(updatedText)
        // Verificar si el valor es menor que 100 y mayor o igual a 0
        if let number = Int(updatedText), number < 100 && number >= 0 {
            if textField == firstRivalResultText {
                firstRivalResultText.text = updatedText
            } else if textField == secondRivalResultText {
                secondRivalResultText.text = updatedText
            }
        }
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        updateResults()
    }
}
