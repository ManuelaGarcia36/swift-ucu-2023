//
//  CustomTableViewCell.swift
//  primer-obligatorio
//
//  Created by Manuela Garcia Lira on 1/5/23.
//

import UIKit
import Kingfisher


protocol CustomTableViewCellDelegate: AnyObject{
    func didSelectedTheButton(cell: UITableViewCell)

    func updateResultGame(cell: UITableViewCell, goalLocal: Int, goalVisit: Int)
}

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
    
    func initCompoents(primaryColor: UIColor, secundaryColor: UIColor, detailsColor: UIColor, match: Match){
        // header card
        headerCellView.backgroundColor = primaryColor
        headerLabel.backgroundColor = secundaryColor
        headerLabel.layer.cornerRadius = 3.0
        headerLabel.clipsToBounds = true
        
        // basic style for cell
        firstRivalResultText.textColor = .white
        secondRivalResultText.textColor = .white
        
        firstRivalResultText.isEnabled = false
        secondRivalResultText.isEnabled = false
        
        let nameHomeTeam = String(match.homeTeamLogo)
        let urlHomeTeam = URL.makeURL(withString: nameHomeTeam)
        firstRivalImage.kf.setImage(with: urlHomeTeam)
        firstRivalLabel.text = match.homeTeamName
        
        let nameAwayTeam = String(match.awayTeamLogo)
        let urlAwayTeam = URL.makeURL(withString: nameAwayTeam)
        secondRivalImage.kf.setImage(with: urlAwayTeam)
        
        secondRivalLabel.text = match.awayTeamName
        if let homeGoals = match.homeTeamGoals {
            firstRivalResultText.text = String(homeGoals)
        } else {
            firstRivalResultText.text = ""
        }
        if let awayGoals = match.awayTeamGoals {
            secondRivalResultText.text = String(awayGoals)
        } else {
            secondRivalResultText.text = ""
        }
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

        switch(match.status) {
            
        case .correct:
            headerLabel.text = " Acertado "
        case .incorrect:
            headerLabel.text = " Errado "
        case .not_predicted:
            headerLabel.text = " Jugado sin resultados  "
        case .pending:
            headerLabel.text = " Pendiente "
            firstRivalResultText.backgroundColor = UIColor.blueBackgroundPickerCard
            secondRivalResultText.backgroundColor = UIColor.blueBackgroundPickerCard
            firstRivalResultText.isEnabled = true
            secondRivalResultText.isEnabled = true
            if let homeGoals = match.predictedHomeGoals {
                firstRivalResultText.text = String(homeGoals)
            } else {
                firstRivalResultText.text = ""
            }
            if let awayGoals = match.predictedAwayGoals {
                secondRivalResultText.text = String(awayGoals)
            } else {
                secondRivalResultText.text = ""
            }
            moreDetailsButton.isHidden = true
            cardPrincipalView.backgroundColor = UIColor.blueBackgroundViewPendingCard
            buttonView.backgroundColor = UIColor.blueBackgroundViewPendingCard
            buttonView.layer.borderColor = UIColor.blueBackgroundViewPendingCard.cgColor
            buttonView.layer.borderWidth = 0
        }
    }
    
    func setup(match: Match){
        switch(match.status) {
        case .correct:
            initCompoents(primaryColor: UIColor.greenBackgroundCard, secundaryColor: UIColor.greenBackgroundLabelCard, detailsColor: UIColor.lightBlueTableViewDetails, match: match)
        case .not_predicted:
            initCompoents(primaryColor: UIColor.greyBackgroundCard, secundaryColor: UIColor.greyBackgroundLabelCard, detailsColor: UIColor.lightBlueTableViewDetails, match: match)
        case .incorrect:
            initCompoents(primaryColor: UIColor.redBackgroundCard, secundaryColor: UIColor.redBackgroundLabelCard, detailsColor: UIColor.lightBlueTableViewDetails, match: match)
        case .pending:
            initCompoents(primaryColor: UIColor.blueBackgroundCard, secundaryColor: UIColor.blueBackgroundLabelCard, detailsColor: UIColor.lightBlueTableViewDetails, match: match)
        }
    }
    
    @IBAction func moreDetailsTaped(_ sender: UIButton) {
        delegate?.didSelectedTheButton(cell: self)
    }
    
    func updateResults() {
       let firstResultText = firstRivalResultText.text ?? ""
       let secondResultText = secondRivalResultText.text ?? ""
        if (firstResultText != "" && secondResultText != "") {
            if let firstResult = Int(firstResultText), let secondResult = Int(secondResultText) {
                delegate?.updateResultGame(cell: self, goalLocal: firstResult, goalVisit: secondResult)
            } else {
                print("The values entered by the user are not valid numbers: \(firstResultText), \(secondResultText)")
            }
        }
    }
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
        if let number = Int(updatedText), number < 100 && number >= 0 {
            if textField == firstRivalResultText {
                firstRivalResultText.text = updatedText
            } else if textField == secondRivalResultText {
                secondRivalResultText.text = updatedText
            }
            updateResults()
        }
        return true
    }
}
