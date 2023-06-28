//
//  ViewController.swift
//  obligatorio-final
//
//  Created by Manuela Garcia Lira on 14/6/23.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var collectionTypesView: UICollectionView!
    @IBOutlet weak var collectionPokemonView: UICollectionView!
    @IBOutlet weak var goToFavoritesButton: UIButton!
    
    private let pokemonManager = PokemonApiService()
    var pokemonList = [DetailPokemon]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        if let starImage = UIImage(systemName: "star.circle") {
           let tintedImage = starImage.withTintColor(.red, renderingMode: .alwaysOriginal)

           goToFavoritesButton.setImage(tintedImage, for: .normal)
           goToFavoritesButton.setTitle("", for: .normal)
       }
            
        collectionTypesView.delegate = self
        collectionTypesView.dataSource = self
        collectionTypesView.register(TypesCustomCollectionViewCell.nib(), forCellWithReuseIdentifier: TypesCustomCollectionViewCell.reuseIdentifier)
        
        
        collectionPokemonView.delegate = self
        collectionPokemonView.dataSource = self
        collectionPokemonView.register(
            PokemonCollectionViewCell.nib(), forCellWithReuseIdentifier: PokemonCollectionViewCell.reuseIdentifier)
        collectionPokemonView.register(EmptyCollectionViewCell.nib(), forCellWithReuseIdentifier: EmptyCollectionViewCell.reuseIdentifier)
        
        pokemonManager.fetchPokemones { [weak self] (details, error) in
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
    
    
    @IBAction func goToFavoriteViewAction(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let destinationVC = storyboard.instantiateViewController(withIdentifier: "FavoritePokemonsID") as! FavoritePokemonsViewController
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
        destinationVC.loadViewIfNeeded()
        destinationVC.modalPresentationStyle = .fullScreen
        destinationVC.configure(with: pokemonList[indexPath.row])
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
                cell.configure(with: pokemon.url)
                return cell
            }
        } else if collectionView == collectionTypesView {
            // collection view buttons filter
            guard let cell  = collectionView.dequeueReusableCell(withReuseIdentifier: TypesCustomCollectionViewCell.reuseIdentifier, for: indexPath) as? TypesCustomCollectionViewCell
            else { return .init()}
            let nameButton = typesList[indexPath.row]
            cell.configure(with: nameButton)
            return cell
        } else {
            fatalError("unknow collection view")
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
