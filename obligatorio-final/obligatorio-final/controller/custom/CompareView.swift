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
    var stats: [StatContainer] = []
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        statstTableView.dataSource = self
        statstTableView.delegate = self
        statstTableView.register(UINib(nibName: DetailPokemonTableViewCell.reuseIdentifier, bundle: nil), forCellReuseIdentifier: DetailPokemonTableViewCell.reuseIdentifier)
    }
    
    func setup(detailPokemon: DetailPokemon) {
        statstTableView.backgroundColor = UIColor(hex: 0x819FC0)
        myContentView.backgroundColor = UIColor(hex: 0x819FC0)
        myContentView.layer.cornerRadius = 15.0
        pokemonNameLabel.text = detailPokemon.name
        pokemonImage.kf.setImage(with: detailPokemon.url)
        idPokemonLabel.text = String("#\(detailPokemon.id)")
        stats = detailPokemon.stats
        statstTableView.reloadData()

    }
    
}

extension CompareView: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stats.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: DetailPokemonTableViewCell.reuseIdentifier, for: indexPath) as? DetailPokemonTableViewCell else {
            return UITableViewCell()
        }
        let stat = stats[indexPath.row]
        cell.configure(with: stat)
        return cell
    }
    
}

extension UIColor {
    convenience init(hex: UInt32, alpha: CGFloat = 1.0) {
        let red = CGFloat((hex & 0xFF0000) >> 16) / 255.0
        let green = CGFloat((hex & 0x00FF00) >> 8) / 255.0
        let blue = CGFloat(hex & 0x0000FF) / 255.0
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
}
