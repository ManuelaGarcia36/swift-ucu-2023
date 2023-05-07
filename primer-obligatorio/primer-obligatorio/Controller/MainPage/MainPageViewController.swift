//
//  MainPageViewController.swift
//  primer-obligatorio
//
//  Created by Manuela Garcia Lira on 1/5/23.
//

import Foundation
import UIKit

class MainPageViewController: UIViewController {
    
    private var equipos: [Equipo]!
    private var partidos: [Partido]!
    @IBOutlet weak var tableView: UITableView!
    private var showingAlert = false
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
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "CustomTableViewCell", bundle: nil), forCellReuseIdentifier: "CustomTableViewCell")
        tableView.backgroundColor = blueBackgroundTableView
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = blueBackgroundTableView
        collectionView.register(UINib(nibName: CustomCollectionViewCell.reuseIdentifier, bundle: nil), forCellWithReuseIdentifier: CustomCollectionViewCell.reuseIdentifier)
        
        searchBar.backgroundColor = blueBackgroundTableView
        filterButton.backgroundColor = blueBackgroundTableView
        pageControl.backgroundColor = blueBackgroundTableView
        labelSearch.backgroundColor = blueBackgroundTableView
        viewHeader.backgroundColor = blueBackgroundTableView
        
        let image = UIImage(systemName: "line.3.horizontal.decrease.circle")
        filterButton.setImage(image, for: .normal)
        filterButton.setTitle("", for: .normal)
    }
    
    
    @objc func slideToNext(){
        if currentCellIndex < bannersActivos.count - 1 {
            currentCellIndex = currentCellIndex + 1
        }else {
            currentCellIndex = 0
        }
        collectionView.scrollToItem(at: IndexPath(item: currentCellIndex, section: 0), at: .right, animated: true)
    }

    /**  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
          if segue.identifier == "DetailsSegue" {
              if segue.destination is DetailsPartidoViewController {
                  // Configurar el controlador de vista de destino si es necesario
              }
          }
        
      } */
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "DetailsSegue" {
            if let partido = sender as? Partido {
                let detailVC = segue.destination as! DetailsPartidoViewController
                detailVC.setUp(partido: partido)
            }
        }
    }

    
    func filtrarPorEstado(_ estado: EstadoPartido) {
        self.partidos = self.partidos.filter { $0.estado == estado }
        self.tableView.reloadData()
    }
    
    @IBAction func filterButton(_ sender: Any) {
        partidos = partidosIniciales
        
        let alert =  UIAlertController(title: "Filtrar partidos", message: "", preferredStyle: .alert)
        
        let verAcertadosAction = UIAlertAction(title: "Ver acertados", style: .default, handler: { [self] action in
            self.filtrarPorEstado(.acertado)
        })
        let verErradosAction = UIAlertAction(title: "Ver errados", style: .default, handler: { [self] action in
            self.filtrarPorEstado(.errado)
        })
        let verPendientesAction = UIAlertAction(title: "Ver pendientes", style: .default, handler: { [self] action in
            self.filtrarPorEstado(.pendiente)
        })
        let verSinResAction = UIAlertAction(title: "Ver jugados sin/res", style: .default, handler: { [self] action in
            self.filtrarPorEstado(.jugado)
        })
        alert.addAction(verAcertadosAction)
        alert.addAction(verErradosAction)
        alert.addAction(verPendientesAction)
        alert.addAction(verSinResAction)
        self.present(alert, animated: true)
        
    }
}

extension MainPageViewController: UITableViewDataSource {
    // tener un objeto dividido por secciones
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let dictionary = Dictionary(grouping: partidos, by: { Calendar.current.startOfDay(for: $0.fecha ?? Date()) })
        
        let sortedDictionary = dictionary.sorted(by: { $0.key < $1.key }).map { (key: $0.key, value: $0.value) }
        
        _ = sortedDictionary.map { $0.key }
        
        if let firstElement = sortedDictionary[safe: section]?.value.first {
          
            let dateString = Date.dateFromToCustomString(date: firstElement.fecha ?? Date())
            
            let label = UILabel()
            label.backgroundColor = blueBackgroundTableView
            label.textColor = .white
            label.translatesAutoresizingMaskIntoConstraints = false
            label.text = dateString
            
            let containerView = UIView()
            containerView.addSubview(label)
            return containerView
        }
        return  UIView()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        let dictionary = Dictionary(grouping: partidos, by: { Calendar.current.startOfDay(for: $0.fecha ?? Date()) })
        
        return dictionary.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        let dictionary = Dictionary(grouping: partidos, by: { Calendar.current.startOfDay(for: $0.fecha ?? Date()) })
        
        let sortedDictionary = dictionary.sorted(by: { $0.key < $1.key }).map { (key: $0.key, value: $0.value) }
        
        let keys = sortedDictionary.map { $0.key }
        
        //  let key = sortedKeys[section]
        let values = keys[section]
        
        return dictionary[values, default: []].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CustomTableViewCell", for: indexPath) as? CustomTableViewCell
        else { return .init()}
        
        
        let dictionary = Dictionary(grouping: partidos, by: { Calendar.current.startOfDay(for: $0.fecha ?? Date()) })
        
        let sortedDictionary = dictionary.sorted(by: { $0.key < $1.key }).map { (key: $0.key, value: $0.value) }
        
        let keys = sortedDictionary.map { $0.key }
        let values = keys[indexPath.section]
        
        let partidoss = dictionary[values, default: []]
        
        
        let partido = partidoss[indexPath.row]
        cell.setup(partido: partido)
        cell.moreDetailsButton.addTarget(self, action: #selector(customTableViewCellDidTapButton(_:)), for: .touchUpInside)
        cell.delegate = self
        return cell
        
    }
}

extension Array {
    subscript (safe index: Int) -> Element? {
        return indices ~= index ? self[index] : nil
    }
}



extension MainPageViewController: UITableViewDelegate {
 
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedPartido = partidos[indexPath.row] // assuming partidos is an array of Partido objects
        performSegue(withIdentifier: "DetailsSegue", sender: selectedPartido)
    }

}

extension MainPageViewController: CustomTableViewCellDelegate {
    @objc func customTableViewCellDidTapButton(_ cell: CustomTableViewCell) {
        performSegue(withIdentifier: "DetailsSegue", sender: cell)
      }
}


extension MainPageViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let cantBanners = bannersActivos.count
        pageControl.numberOfPages = cantBanners
        return cantBanners
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CustomCollectionViewCell.reuseIdentifier, for: indexPath) as? CustomCollectionViewCell
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

var searchEquipo = [String]()

extension MainPageViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchEquipo = []
        if searchText.isEmpty {
            partidos = partidosIniciales
            tableView.reloadData()
            return
        }
        partidos = filtrarPartidosPorEquipo(nombreEquipo: searchText)
        tableView.reloadData()
    }
    
    func filtrarPartidosPorEquipo(nombreEquipo: String) -> [Partido] {
        return partidos.filter { partido in
            return partido.equipoLocal.nombre.lowercased().contains(nombreEquipo.lowercased())
            || partido.equipoVisitante.nombre.lowercased().contains(nombreEquipo.lowercased())
        }
    }
    
    
}
