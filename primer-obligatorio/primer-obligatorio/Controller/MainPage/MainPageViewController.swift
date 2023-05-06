//
//  MainPageViewController.swift
//  primer-obligatorio
//
//  Created by Manuela Garcia Lira on 1/5/23.
//

import Foundation
//
//  ViewController.swift
//  primer-obligatorio
//
//  Created by Manuela Garcia Lira on 26/4/23.
//

import UIKit

class MainPageViewController: UIViewController {
    
    private var equipos: [Equipo]!
    private var partidos: [Partido]!
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var viewHeader: UIView!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var pageControl: UIPageControl!
    var currentCellIndex = 0;
    
    @IBOutlet weak var labelSearch: UILabel!
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var filterButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pageControl.currentPage = 0
        
        equipos = equiposIniciales
        partidos = partidosIniciales
        
        print(equipos.count)
        print(partidos.count)
    
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "CustomTableViewCell", bundle: nil), forCellReuseIdentifier: "CustomTableViewCell")
               
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.register(UINib(nibName: CustomCollectionViewCell.reuseIdentifier, bundle: nil), forCellWithReuseIdentifier: "CustomCollectionViewCell")
        
        let filterButton = UIButton()
        filterButton.setImage(UIImage(systemName: "line.3.horizontal.decrease.circle"), for: .normal)
        
       
        filterButton.addTarget(self, action: #selector(filterButtonTapped), for: .touchUpInside)
    


    }
    
    @objc func slideToNext(){
        if currentCellIndex < bannersActivos.count - 1 {
            currentCellIndex = currentCellIndex + 1
        }else {
            currentCellIndex = 0
        }
        collectionView.scrollToItem(at: IndexPath(item: currentCellIndex, section: 0), at: .right, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "FilterAlertViewController" {
            if let destinationVC = segue.destination as? FilterAlertViewController {
               // destinationVC.param = textParam.text ?? "defaultText"
            }
        }
            
    }
    
    @objc func filterButtonTapped() {
           // acción al presionar el botón
       }
}

extension MainPageViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return partidos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CustomTableViewCell", for: indexPath) as? CustomTableViewCell
        else { return .init()}
       
        let partido = partidos[indexPath.row]
        cell.setup(partido: partido)
        return cell
        
    }
}

extension MainPageViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
}


extension MainPageViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let cantBanners = bannersActivos.count
        pageControl.numberOfPages = cantBanners
        return cantBanners
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CustomCollectionViewCell", for: indexPath) as? CustomCollectionViewCell
        else { return .init()}
       
        let elemt = bannersActivos[indexPath.row]
        cell.setup(image: elemt)
        return cell
    }
    
}

extension MainPageViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {
   
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offSet = scrollView.contentOffset.x
        let width = scrollView.frame.width
        let horizontalCenter = width / 2

        pageControl.currentPage = Int(offSet + horizontalCenter) / Int(width)
    }
 
}

