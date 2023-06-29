//
//  CompareView.swift
//  obligatorio-final
//
//  Created by Manuela Garcia Lira on 28/6/23.
//

import Foundation
import UIKit
import Kingfisher

class CompareView: NibLoadingView {

    @IBOutlet weak var myContentView: UIView!
    @IBOutlet weak var idPokemonLabel: UILabel!
    @IBOutlet weak var pokemonImage: UIImageView!
    @IBOutlet weak var pokemonNameLabel: UILabel!
    @IBOutlet weak var statstTableView: UITableView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        statstTableView.dataSource = self
        statstTableView.delegate = self
        statstTableView.register(UINib(nibName: DetailPokemonTableViewCell.reuseIdentifier, bundle: nil), forCellReuseIdentifier: DetailPokemonTableViewCell.reuseIdentifier)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
    
    func setup(detailPokemon: DetailPokemon) {
        pokemonNameLabel.text = detailPokemon.name
        pokemonImage.kf.setImage(with: detailPokemon.url)
        idPokemonLabel.text = String("#\(detailPokemon.id)")
    }
    
}

extension CompareView: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: DetailPokemonTableViewCell.reuseIdentifier, for: indexPath) as? DetailPokemonTableViewCell else {
            return UITableViewCell()
        }
        let statListPokemon = [StatContainer(stat: StatName(name: "pk"), base_stat: 49),StatContainer(stat: StatName(name: "pk"), base_stat: 49),StatContainer(stat: StatName(name: "pk"), base_stat: 49),StatContainer(stat: StatName(name: "pk"), base_stat: 49),StatContainer(stat: StatName(name: "pk"), base_stat: 49)]
        let stat = statListPokemon[indexPath.row]
        cell.configure(with: stat)
        return cell
    }
    
}
