//
//  DetailPokemonViewController.swift
//  obligatorio-final
//
//  Created by Manuela Garcia Lira on 22/6/23.
//

import Foundation

import UIKit

class DetailPokemonViewController: UIViewController {
    
    @IBOutlet weak var contentImageView: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var pokemonImage: UIImageView!
    @IBOutlet weak var pokemonNameLabel: UILabel!
    @IBOutlet weak var typeCollectionView: UICollectionView!
    @IBOutlet weak var weightNumberLabel: UILabel!
    @IBOutlet weak var heightNumberLabel: UILabel!
    
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var goComparePokemonsButton: UIButton!
    
    var statListPokemon: [StatContainer] = []
    var colorPokemon: String = ""
    var typesPokemon: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: DetailPokemonTableViewCell.reuseIdentifier, bundle: nil), forCellReuseIdentifier: DetailPokemonTableViewCell.reuseIdentifier)
        
        typeCollectionView.delegate = self
        typeCollectionView.dataSource = self
        typeCollectionView.register(TypesCustomCollectionViewCell.nib(), forCellWithReuseIdentifier: TypesCustomCollectionViewCell.reuseIdentifier)
        
    }
    
    func configure(with poke: DetailPokemon) {
        pokemonNameLabel.text = String(poke.name)
        // TODO: add types for collection view
        weightNumberLabel.text = String(poke.weight)
        heightNumberLabel.text = String(poke.height)
        pokemonImage.kf.setImage(with: poke.url)
        statListPokemon = poke.stats
        colorPokemon = "green" // fixme: resolve color pokemon
        typesPokemon = poke.types
        
        let randomColor = UIColor.random()
        contentImageView.backgroundColor = randomColor

        // Aplicar el radio de esquina solo a los costados inferiores
        contentImageView.layer.cornerRadius = 25.0
        contentImageView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        contentImageView.layer.masksToBounds = true

        
        // if isFav
        
        
        // else
    }

    
    @IBAction func goCompareView(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
                           let destinationVC = storyboard.instantiateViewController(withIdentifier: "ComparativeID") as! ComparativePokemonsViewController
                           destinationVC.modalPresentationStyle = .fullScreen
                           self.navigationController?.pushViewController(destinationVC, animated: true)
    }
    
    
    @IBAction func favoriteAction(_ sender: Any) {
        // SI esta guardado entonces eliminar, si no guardar y cambiar icono
        
    }
    
}

extension DetailPokemonViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return statListPokemon.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: DetailPokemonTableViewCell.reuseIdentifier, for: indexPath) as? DetailPokemonTableViewCell else {
            return UITableViewCell()
        }

        let stat = statListPokemon[indexPath.row]
      //  cell.configure(with: stat.name, stat: stat.value)
        return cell
    }
    
}

extension DetailPokemonViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return typesPokemon.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
       guard let cell  = collectionView.dequeueReusableCell(withReuseIdentifier: TypesCustomCollectionViewCell.reuseIdentifier, for: indexPath) as? TypesCustomCollectionViewCell
            else { return .init()}
            let nameButton = typesPokemon[indexPath.row]
            cell.configure(with: nameButton)
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
