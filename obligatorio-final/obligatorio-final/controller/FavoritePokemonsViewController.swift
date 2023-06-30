//
//  FavoritePokemonsViewController.swift
//  obligatorio-final
//
//  Created by Manuela Garcia Lira on 22/6/23.
//

import Foundation
import UIKit
import Kingfisher


class FavoritePokemonsViewController: UIViewController {
    
    @IBOutlet weak var headerImage: UIImageView!
    @IBOutlet weak var pokemonCollectionView: UICollectionView!
    @IBOutlet weak var viewTiteleLabel: UILabel!
    @IBOutlet weak var pageControlByScrolView: UIPageControl!
    var favoritesList = FavoritesList()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewTiteleLabel.text = "Favorites"
        headerImage.image = UIImage(named: "logo_v2")
        
        view.bringSubviewToFront(pageControlByScrolView)
        
        pokemonCollectionView.delegate = self
        pokemonCollectionView.dataSource = self
        pokemonCollectionView.register(
            PokemonCollectionViewCell.nib(), forCellWithReuseIdentifier: PokemonCollectionViewCell.reuseIdentifier)
        pokemonCollectionView.register(EmptyCollectionViewCell.nib(), forCellWithReuseIdentifier: EmptyCollectionViewCell.reuseIdentifier)
        
        pageControlByScrolView.numberOfPages = FavoritesList.shared.getList().count
        pageControlByScrolView.currentPage = 0
        
        pokemonCollectionView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
         super.viewWillAppear(animated)
         
         // Recargar los datos de la lista de favoritos aquí
        pokemonCollectionView.reloadData()
     }
}

extension FavoritePokemonsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == pokemonCollectionView {
            if FavoritesList.shared.getList().count == 0 { return 1 } else {
                return FavoritesList.shared.getList().count
            }
        } else {
            fatalError("unknow collection view")
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let destinationVC = storyboard.instantiateViewController(withIdentifier: "DetailPokemonID") as! DetailPokemonViewController
        destinationVC.modalPresentationStyle = .fullScreen
        let list = FavoritesList.shared.getList()
        destinationVC.detailPokemon = list[indexPath.row]
        destinationVC.loadViewIfNeeded()
        self.navigationController?.pushViewController(destinationVC, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == pokemonCollectionView {
            if FavoritesList.shared.getList().isEmpty {
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: EmptyCollectionViewCell.reuseIdentifier, for: indexPath) as? EmptyCollectionViewCell else {
                    return UICollectionViewCell()
                }
                return cell
            } else {
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PokemonCollectionViewCell.reuseIdentifier, for: indexPath) as? PokemonCollectionViewCell else {
                    return UICollectionViewCell()
                }
                let list = FavoritesList.shared.getList()
                let item = list[indexPath.row]
                cell.configure(with: item.url, color: item.color)
                return cell
            }
        }
        fatalError("Unknown collection view")
    }
    
}

extension FavoritePokemonsViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == pokemonCollectionView {
            if FavoritesList.shared.getList().isEmpty {
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
