//
//  ViewController.swift
//  obligatorio-final
//
//  Created by Manuela Garcia Lira on 14/6/23.
//

import UIKit
import Kingfisher

class HomeViewController: UIViewController {
    
    @IBOutlet weak var collectionTypesView: UICollectionView!
    @IBOutlet weak var collectionPokemonView: UICollectionView!
    @IBOutlet weak var goToFavoritesButton: UIButton!
    @IBOutlet weak var profileButton: UIButton!
    
    private let pokemonManager = PokemonApiService()
    var pokemonList = [DetailPokemon]()
    var favoritesList: FavoritesList?
    var currentPage = 0
    let itemsPerPage = 20
    var isLoadMoreData = false

    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let starFavoritesImage = UIImage(systemName: "heart.fill") {
            let configuration = UIImage.SymbolConfiguration(pointSize: 24)
            let tintedImage = starFavoritesImage.withTintColor(.red, renderingMode: .alwaysOriginal)
                                                  .withConfiguration(configuration)
            goToFavoritesButton.setImage(tintedImage, for: .normal)
            goToFavoritesButton.setTitle("", for: .normal)
        }

        if let startProfileImage = UIImage(systemName: "person.crop.circle") {
            let configuration = UIImage.SymbolConfiguration(pointSize: 24)
            let tintedImage = startProfileImage.withTintColor(.red, renderingMode: .alwaysOriginal)
                                               .withConfiguration(configuration)
            profileButton.setImage(tintedImage, for: .normal)
            profileButton.setTitle("", for: .normal)
        }

        collectionTypesView.delegate = self
        collectionTypesView.dataSource = self
        collectionTypesView.register(TypesCustomCollectionViewCell.nib(), forCellWithReuseIdentifier: TypesCustomCollectionViewCell.reuseIdentifier)
        
        
        collectionPokemonView.delegate = self
        collectionPokemonView.dataSource = self
        collectionPokemonView.register(
            PokemonCollectionViewCell.nib(), forCellWithReuseIdentifier: PokemonCollectionViewCell.reuseIdentifier)
        collectionPokemonView.register(EmptyCollectionViewCell.nib(), forCellWithReuseIdentifier: EmptyCollectionViewCell.reuseIdentifier)
        
        pokemonManager.fetchPokemones(page: currentPage, limit: itemsPerPage) { [weak self] (details, error) in
            if let error = error {
                print("Error getting pokemon list and details: \(error)")
            } else {
                if let pokeDetail = details {
                    self?.pokemonList = pokeDetail
                    self?.collectionPokemonView.reloadData()
                }
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Visibility of the back button
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // Restore the visibility of the back button in the navigation bar for other screens
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    @IBAction func goToFavoriteViewAction(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let destinationVC = storyboard.instantiateViewController(withIdentifier: "FavoritePokemonsID") as! FavoritePokemonsViewController
        destinationVC.loadViewIfNeeded()
        destinationVC.modalPresentationStyle = .fullScreen
        self.navigationController?.pushViewController(destinationVC, animated: true)
    }
    
    @IBAction func profileButtonAction(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let destinationVC = storyboard.instantiateViewController(withIdentifier: "ProfileViewControllerID") as! ProfileViewController
        destinationVC.loadViewIfNeeded()
        destinationVC.modalPresentationStyle = .fullScreen
        self.navigationController?.pushViewController(destinationVC, animated: true)
    }

}

extension HomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == collectionPokemonView {
            if pokemonList.count == 0 { return 1 } else {
                return pokemonList.count
            }
        } else if collectionView == collectionTypesView {
            return typesList.count
        } else {
            fatalError("unknow collection view")
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let destinationVC = storyboard.instantiateViewController(withIdentifier: "DetailPokemonID") as! DetailPokemonViewController
        destinationVC.modalPresentationStyle = .fullScreen
        destinationVC.detailPokemon = pokemonList[indexPath.row]
        destinationVC.loadViewIfNeeded()
        self.navigationController?.pushViewController(destinationVC, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == collectionPokemonView {
            if (pokemonList.count == 0) {
                guard let cell  = collectionView.dequeueReusableCell(withReuseIdentifier: EmptyCollectionViewCell.reuseIdentifier, for: indexPath) as? EmptyCollectionViewCell
                else { return .init()}
                return cell
            } else {
                // collection view image pokemon
                guard let cell  = collectionView.dequeueReusableCell(withReuseIdentifier: PokemonCollectionViewCell.reuseIdentifier, for: indexPath) as? PokemonCollectionViewCell
                else { return .init()}
                let pokemon = pokemonList[indexPath.row]
                cell.configure(with: pokemon.url,color:     pokemon.color)
                return cell
            }
        } else if collectionView == collectionTypesView {
            // collection view buttons filter
            guard let cell  = collectionView.dequeueReusableCell(withReuseIdentifier: TypesCustomCollectionViewCell.reuseIdentifier, for: indexPath) as? TypesCustomCollectionViewCell
            else { return .init()}
            let nameButton = typesList[indexPath.row]
            cell.setup(with: nameButton)
            return cell
        } else {
            fatalError("unknow collection view")
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let position = scrollView.contentOffset.y
        // comprueba si la posición actual del desplazamiento es mayor que del final del contenido de la vista de desplazamiento
        if position > (collectionPokemonView.contentSize.height-scrollView.frame.size.height) {
            if (!isLoadMoreData) {
                isLoadMoreData = true
                currentPage += 1
                pokemonManager.fetchPokemones(page: currentPage, limit: itemsPerPage) { [weak self] (details, error) in
                    if let error = error {
                        print("Error getting pokemon list and details: \(error)")
                    } else {
                        if let pokeDetail = details {
                            self?.pokemonList.append(contentsOf: pokeDetail)
                            self?.collectionPokemonView.reloadData()
                            self?.isLoadMoreData = false
                        }
                    }
                }
            }
        }
    }
}

extension HomeViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == collectionPokemonView {
            if (pokemonList.count == 0) {
                return CGSize(width: collectionView.bounds.width , height: collectionView.bounds.height/2)
            }
            let itemSize = (collectionView.bounds.width - 2*2) / 2
            return CGSize(width: itemSize, height: itemSize)
        } else if collectionView == collectionTypesView {
            return CGSize(width: 1, height: 1)
        } else {
            fatalError("unknow collection view")
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        if collectionView == collectionPokemonView {
            return 0
        } else if collectionView == collectionTypesView {
            return 5
        } else {
            fatalError("unknow collection view")
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        if collectionView == collectionPokemonView {
            return 0
        } else if collectionView == collectionTypesView {
            return 5
        } else {
            fatalError("unknow collection view")
        }
    }
}
