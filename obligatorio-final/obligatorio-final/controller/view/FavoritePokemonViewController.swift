//
//  FavoritePokemonViewController.swift
//  obligatorio-final
//
//  Created by Manuela Garcia Lira on 22/6/23.
//

import Foundation
import UIKit

class FavoritePokemonViewController: UIViewController {
    
    @IBOutlet weak var headerImage: UIImageView!
    @IBOutlet weak var pokemonCollectionView: UICollectionView!
    
    var favoritesList = FavoritesRepository()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Favorites"
        headerImage.image = UIImage(named: "logoPokemon")
        
        pokemonCollectionView.delegate = self
        pokemonCollectionView.dataSource = self
        pokemonCollectionView.register(
            PokemonCollectionViewCell.nib(), forCellWithReuseIdentifier: PokemonCollectionViewCell.reuseIdentifier)
        pokemonCollectionView.register(EmptyCollectionViewCell.nib(), forCellWithReuseIdentifier: EmptyCollectionViewCell.reuseIdentifier)
        
        pokemonCollectionView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Reload favorites list data for each appear
        pokemonCollectionView.reloadData()
    }
}

extension FavoritePokemonViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == pokemonCollectionView {
            if FavoritesRepository.shared.getList().count == 0 { return 1 } else {
                return FavoritesRepository.shared.getList().count
            }
        } else {
            fatalError("unknow collection view")
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let destinationVC = storyboard.instantiateViewController(withIdentifier: "DetailPokemonID") as! DetailPokemonViewController
        destinationVC.modalPresentationStyle = .fullScreen
        let list = FavoritesRepository.shared.getList()
        destinationVC.detailPokemon = list[indexPath.row]
        destinationVC.loadViewIfNeeded()
        self.navigationController?.pushViewController(destinationVC, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == pokemonCollectionView {
            if FavoritesRepository.shared.getList().isEmpty {
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: EmptyCollectionViewCell.reuseIdentifier, for: indexPath) as? EmptyCollectionViewCell else {
                    return UICollectionViewCell()
                }
                return cell
            } else {
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PokemonCollectionViewCell.reuseIdentifier, for: indexPath) as? PokemonCollectionViewCell else {
                    return UICollectionViewCell()
                }
                let list = FavoritesRepository.shared.getList()
                let item = list[indexPath.row]
                cell.setup(with: item.url, id: String(item.id), color: item.color)
                return cell
            }
        }
        fatalError("Unknown collection view")
    }
    
}

extension FavoritePokemonViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == pokemonCollectionView {
            if FavoritesRepository.shared.getList().isEmpty {
                return CGSize(width: collectionView.bounds.width, height: collectionView.bounds.height/2)
            }
            let itemSize = collectionView.bounds.width - 2 * 2
            return CGSize(width: itemSize, height: itemSize)
        } else {
            fatalError("Unknown collection view")
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        if collectionView == pokemonCollectionView {
            return 5
        } else {
            fatalError("unknow collection view")
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        if collectionView == pokemonCollectionView {
            return 5
        } else {
            fatalError("unknow collection view")
        }
    }
}
