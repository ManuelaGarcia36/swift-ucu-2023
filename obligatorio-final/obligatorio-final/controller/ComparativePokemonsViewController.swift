//
//  ComparativePokemonsView.swift
//  obligatorio-final
//
//  Created by Manuela Garcia Lira on 22/6/23.
//

import Foundation
import UIKit

class ComparativePokemonsViewController: UIViewController {
    
    @IBOutlet weak var headerTitleLabel: UILabel!
    @IBOutlet weak var headerImageView: UIImageView!
    @IBOutlet weak var principalPokemonView: CompareView!
    @IBOutlet weak var secundaryPokemonView: CompareView!
    @IBOutlet weak var compareButton: UIButton!
   
    var detailPokemon: DetailPokemon?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    func setup() {
        headerImageView.image = UIImage(named: "logo_v2")
        if let detail = detailPokemon {
            principalPokemonView.setup(detailPokemon: detail)
        }
        
        // TODO: Implementar busqueda y carga de datos
        if let detail2 = detailPokemon {
            secundaryPokemonView.setup(detailPokemon: detail2)
        }
    }
    
}
