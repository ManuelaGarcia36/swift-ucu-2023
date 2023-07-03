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
    @IBOutlet weak var notFoundLabel: UILabel!
    @IBOutlet weak var searchByPokemonNameTextField: UITextField!
    
    private let pokemonManager = PokemonApiService()
    var detailPokemon: DetailPokemon?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    func setup() {
        // Se inicia la view del primer pokemon
        headerImageView.image = UIImage(named: "logo_v2")
        if let detail = detailPokemon {
            principalPokemonView.setup(detailPokemon: detail)
        }
        // Los componentes del segundo pokemon se esconden hasta que el usuario realice una busqueda
        secundaryPokemonView.isHidden = true
        notFoundLabel.isHidden = true
    }
    
    @IBAction func searchRivalToCompareActionButton(_ sender: Any) {
        let name = searchByPokemonNameTextField.text ?? ""
        pokemonManager.fetchPokemonByName(name: name) { [weak self] (details, error) in
            if let error = error {
                self?.notFoundLabel.isHidden = false
                self?.secundaryPokemonView.isHidden = true
            } else {
                if let pokeDetail = details {
                    self?.detailPokemon = pokeDetail
                    self?.secundaryPokemonView.setup(detailPokemon: pokeDetail)
                    self?.secundaryPokemonView.isHidden = false
                    self?.notFoundLabel.isHidden = true
                }
            }
        }
    }
}
