//
//  ViewController.swift
//  obligatorio-final
//
//  Created by Manuela Garcia Lira on 14/6/23.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var collectionTypesView: UICollectionView!
    @IBOutlet weak var collectionPokemonView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        collectionTypesView.delegate = self
        collectionTypesView.dataSource = self
        collectionTypesView.register(TypesCustomCollectionViewCell.nib(), forCellWithReuseIdentifier: TypesCustomCollectionViewCell.reuseIdentifier)
        
        
        collectionPokemonView.delegate = self
        collectionPokemonView.dataSource = self
        collectionPokemonView.register(
            PokemonCollectionViewCell.nib(), forCellWithReuseIdentifier: PokemonCollectionViewCell.reuseIdentifier)
        
    }
}

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == collectionPokemonView {
            return 100
        } else if collectionView == collectionTypesView {
            return typesList.count
        } else {
            fatalError("unknow collection view")
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
        if collectionView == collectionPokemonView {
            guard let cell  = collectionView.dequeueReusableCell(withReuseIdentifier: PokemonCollectionViewCell.reuseIdentifier, for: indexPath) as? PokemonCollectionViewCell
                
            else { return .init()}
            
            cell.configure(with: UIImage(named: "pokeImage"))
            return cell
        } else if collectionView == collectionTypesView {
            guard let cell  = collectionView.dequeueReusableCell(withReuseIdentifier: TypesCustomCollectionViewCell.reuseIdentifier, for: indexPath) as? TypesCustomCollectionViewCell
                
            else { return .init()}
            
            cell.configure(with: typesList[indexPath.row])
            return cell
        } else {
            fatalError("unknow collection view")
        }
        
    
    }
    
    
}

extension ViewController: UITableViewDelegate {
    
    // TODO: PRINT CELL SELECTION
    // crear data source
    // usando el datasource
    // sean image Views
    //configurar la celda
}

extension ViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == collectionPokemonView {
            // El tamaño de la celda esta determinado por el ancho, - el espacio de separacion * cantidad de items / 2 que son los que quiero
            let itemSize = (collectionView.bounds.width - 2*2) / 2
            return CGSize(width: itemSize, height: itemSize)
        } else if collectionView == collectionTypesView {
            return CGSize(width: 1, height: 1)
        } else {
            fatalError("unknow collection view")
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
