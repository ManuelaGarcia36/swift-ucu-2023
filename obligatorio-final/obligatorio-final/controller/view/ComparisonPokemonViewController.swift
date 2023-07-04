//
//  ComparativePokemonsView.swift
//  obligatorio-final
//
//  Created by Manuela Garcia Lira on 22/6/23.
//

import Foundation
import UIKit

class ComparisonPokemonViewController: UIViewController {
    
    @IBOutlet weak var headerTitleLabel: UILabel!
    @IBOutlet weak var headerImageView: UIImageView!
    @IBOutlet weak var principalPokemonView: ComparePokemonView!
    @IBOutlet weak var secundaryPokemonView: ComparePokemonView!
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
        headerImageView.image = UIImage(named: "logoPokemon")
        // only initialized first pokemon
        if let detail = detailPokemon {
            principalPokemonView.setup(detailPokemon: detail)
        }
        
        secundaryPokemonView.isHidden = true
        notFoundLabel.isHidden = true
    }
    
    @IBAction func searchRivalToCompareActionButton(_ sender: Any) {
        let name = searchByPokemonNameTextField.text ?? ""
        pokemonManager.fetchPokemonByName(name: name) { [weak self] (details, error) in
            if let _ = error {
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
