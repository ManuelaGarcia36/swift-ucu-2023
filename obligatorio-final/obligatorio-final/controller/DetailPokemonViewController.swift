//
//  DetailPokemonViewController.swift
//  obligatorio-final
//
//  Created by Manuela Garcia Lira on 22/6/23.
//

import Foundation

import UIKit

class DetailPokemonViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var contentImageView: UIView!
    @IBOutlet weak var pokemonImage: UIImageView!
    
    @IBOutlet weak var pokemonNameLabel: UILabel!
    @IBOutlet weak var weightNumberLabel: UILabel!
    @IBOutlet weak var heightNumberLabel: UILabel!
    
    @IBOutlet weak var typeCollectionView: UICollectionView!
    
    @IBOutlet weak var goComparePokemonsButton: UIButton!
    
    // TODO: Implementar @IBOutlet weak var favoriteButton: UIButton!
    
    var detailPokemon: DetailPokemon?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: DetailPokemonTableViewCell.reuseIdentifier, bundle: nil), forCellReuseIdentifier: DetailPokemonTableViewCell.reuseIdentifier)
        
        typeCollectionView.delegate = self
        typeCollectionView.dataSource = self
        typeCollectionView.register(TypesCustomCollectionViewCell.nib(), forCellWithReuseIdentifier: TypesCustomCollectionViewCell.reuseIdentifier)
        
        setup()
    }
    
    
    func setup() {
        if let name = detailPokemon?.name {
            pokemonNameLabel.text = String(name)
        }
        if let weight = detailPokemon?.weight {
            weightNumberLabel.text = String(weight)
        }
        if let height = detailPokemon?.height {
            heightNumberLabel.text = String(height)
        }
        
        if let url = detailPokemon?.url {
            print(url)
            pokemonImage.kf.setImage(with: url)
        }
        
        contentImageView.backgroundColor = detailPokemon?.color
        // Aplicar el radio de esquina solo a los costados inferiores
        contentImageView.layer.cornerRadius = 55.0
        contentImageView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        contentImageView.layer.masksToBounds = true
        
        // Configurar el color de fondo del UINavigationBar
        //navigationController?.navigationBar.tintColor = contentImageView.backgroundColor
        //navigationController?.navigationBar.isTranslucent = false
        
    }
    
    
    @IBAction func goCompareView(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let destinationVC = storyboard.instantiateViewController(withIdentifier: "ComparativeID") as! ComparativePokemonsViewController
        destinationVC.modalPresentationStyle = .fullScreen
        destinationVC.detailPokemon = detailPokemon
        destinationVC.loadViewIfNeeded()
        self.navigationController?.pushViewController(destinationVC, animated: true)
    }
    
}

extension DetailPokemonViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return detailPokemon?.stats.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: DetailPokemonTableViewCell.reuseIdentifier, for: indexPath) as? DetailPokemonTableViewCell else {
            return UITableViewCell()
        }
        if let statContainer = detailPokemon?.stats[indexPath.row] {
            cell.configure(with: statContainer)
        }
        return cell
    }
    
}

extension DetailPokemonViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return detailPokemon?.types.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell  = collectionView.dequeueReusableCell(withReuseIdentifier: TypesCustomCollectionViewCell.reuseIdentifier, for: indexPath) as? TypesCustomCollectionViewCell
        else { return .init()}
        if let nameButton = detailPokemon?.types[indexPath.row] {
            cell.setup(with: nameButton)
        }
        return cell
    }
}

extension DetailPokemonViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 1, height: 1)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
}
