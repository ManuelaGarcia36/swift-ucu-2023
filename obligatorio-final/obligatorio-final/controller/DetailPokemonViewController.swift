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
    
    var detailPokemon: DetailPokemon?
    var isFavorite: Bool = false
    var favoritesList = FavoritesList()
    
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
    
    @objc func favoriteButtonTapped() {
        isFavorite.toggle()
        updateFavoriteButtonAppearance()
        updateFavoriteStatus()
    }

    func updateFavoriteStatus() {
        if let pokemonID = detailPokemon {
            if FavoritesList.shared.isFavorite(pokemonID) {
                print("eliminando de favorito")
                FavoritesList.shared.removeFavorite(pokemonID)
            } else {
                print("agregando a favorito")
                FavoritesList.shared.addFavorite(pokemonID)
            }
        }
    }
    
    func updateFavoriteButtonAppearance() {
        let favoriteButton = UIBarButtonItem(image: UIImage(systemName: isFavorite ? "heart.fill" : "heart"), style: .plain, target: self, action: #selector(favoriteButtonTapped))
        navigationItem.rightBarButtonItem = favoriteButton
    }

    
    func setup() {
        updateFavoriteButtonAppearance()
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
            pokemonImage.kf.setImage(with: url)
        }
        
        contentImageView.backgroundColor = detailPokemon?.color
        // Aplicar el radio de esquina solo a los costados inferiores
        contentImageView.layer.cornerRadius = 55.0
        contentImageView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        contentImageView.layer.masksToBounds = true
        
        if let pokemon = detailPokemon {
            isFavorite = FavoritesList.shared.isFavorite(pokemon)
            updateFavoriteButtonAppearance()
        }
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
