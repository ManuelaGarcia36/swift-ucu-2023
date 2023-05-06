//
//  CustomTableViewCell.swift
//  primer-obligatorio
//
//  Created by Manuela Garcia Lira on 1/5/23.
//

import UIKit

class CustomTableViewCell: UITableViewCell {

    //@IBOutlet weak var headerView: UIView!
    
    @IBOutlet weak var primerRivalImage: UIImageView!
    
    @IBOutlet weak var primerRivalResultText: UITextField!
    @IBOutlet weak var primerRivalLabel: UILabel!
    @IBOutlet weak var segundoRivalImage: UIImageView!
    
    @IBOutlet weak var segundoRivalResultText: UITextField!
    @IBOutlet weak var segundoRivalLabel: UILabel!
    

    @IBOutlet weak var moreDetailsButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }
    
    func setup(partido: Partido){
        primerRivalImage.image = partido.equipoLocal.imagen
        primerRivalLabel.text = partido.equipoLocal.nombre
        
        segundoRivalImage.image = partido.equipoVisitante.imagen
        segundoRivalLabel.text = partido.equipoVisitante.nombre
    }
    
    // FIXME 
   // @IBAction func buttonTapped(_ sender: Any) {
        //let storyboard = UIStoryboard(name: "MainPage", bundle: nil)
        //let destinationVC = storyboard.instantiateViewController(withIdentifier: "FilterAlertViewController") as! FilterAlertViewController
     //   destinationVC.param = textParam.text ?? "defaultText"
       //FIXME super.navigationController?.pushViewController(destinationVC, animated: true)
    //}
    
}

