//
//  CustomTableViewCell.swift
//  primer-obligatorio
//
//  Created by Manuela Garcia Lira on 1/5/23.
//

import UIKit
import Kingfisher

class MatchCustomTableViewCell: UITableViewCell {
    
    static let reuseIdentifier :String = "MatchCustomTableViewCell"
    
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
    weak var delegate: MatchCustomTableViewCellDelegate?
    
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
        myContentView.layer.cornerRadius = 5.0
        myContentView.clipsToBounds = true
        headerCellView.layer.cornerRadius = 5.0
        headerCellView.clipsToBounds = true
        headerCellView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        buttonView.layer.cornerRadius = 5.0
        buttonView.clipsToBounds = true
        buttonView.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]

        
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
    
    func changeColors(primaryColor: UIColor, secundaryColor: UIColor, detailsColor: UIColor, game: MatchResponse){
        // header card
        headerCellView.backgroundColor = primaryColor
        headerLabel.backgroundColor = secundaryColor
        headerLabel.layer.cornerRadius = 3.0
        headerLabel.clipsToBounds = true
        
        // basic style for cell
        firstRivalResultText.textColor = .white
        secondRivalResultText.textColor = .white
        
        // FIXME
        let name = String(game.homeTeamLogo)
        let url = URL(string: "https://\(name)")
        firstRivalImage.kf.setImage(with: url!)
        
        firstRivalLabel.text = game.homeTeamName
        // secondRivalImage.image = game.rivalTeam.imageTeam
        
        let name2 = String(game.awayTeamLogo)
        let url2 = URL(string: "https://\(name2)")
        secondRivalImage.kf.setImage(with: url2!)
        
        secondRivalLabel.text = game.awayTeamName
        
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
            
        case .correct:
            headerLabel.text = " Acertado "
        case .incorrect:
            headerLabel.text = " Errado "
        case .not_predicted:
            firstRivalResultText.text = "-"
            secondRivalResultText.text = "-"
            headerLabel.text = " Jugado sin resultados "
        case .pending:
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
    
    func setup(partido: MatchResponse){
        switch(partido.status) {
        case .correct:
            changeColors(primaryColor: UIColor.greenBackgroundCard, secundaryColor: UIColor.greenBackgroundLabelCard, detailsColor: UIColor.lightBlueTableViewDetails, game: partido)
        case .not_predicted:
            changeColors(primaryColor: UIColor.greyBackgroundCard, secundaryColor: UIColor.greyBackgroundLabelCard, detailsColor: UIColor.lightBlueTableViewDetails, game: partido)
        case .incorrect:
            changeColors(primaryColor: UIColor.redBackgroundCard, secundaryColor: UIColor.redBackgroundLabelCard, detailsColor: UIColor.lightBlueTableViewDetails, game: partido)
        case .pending:
            changeColors(primaryColor: UIColor.blueBackgroundCard, secundaryColor: UIColor.blueBackgroundLabelCard, detailsColor: UIColor.lightBlueTableViewDetails, game: partido)
        }
    }
    
    @IBAction func moreDetailsTaped(_ sender: UIButton) {
        delegate?.didSelectedTheButton(cell: self)
    }
    
    func updateResults() {
        let firstResult = Int(firstRivalResultText.text ?? "") ?? 0
        let secondResult = Int(secondRivalResultText.text ?? "") ?? 0
        delegate?.updateResultGame(cell: self, goalLocal: firstResult, goalVisit: secondResult)
    }
}

protocol MatchCustomTableViewCellDelegate: AnyObject{
    func didSelectedTheButton(cell: UITableViewCell)

    func updateResultGame(cell: UITableViewCell, goalLocal: Int, goalVisit: Int)
}

extension MatchCustomTableViewCell: UITextFieldDelegate {
    
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