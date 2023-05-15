//
//  MainPageViewController.swift
//  primer-obligatorio
//
//  Created by Manuela Garcia Lira on 1/5/23.
//

import Foundation
import UIKit

class MainPageViewController: UIViewController {
    
    // Lista de partidos y equipos
    private var teamsList: [Team]!
    private var gamesList: [Game]!
    
    // outlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var labelSearch: UILabel!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var filterButton: UIButton!
    
    private var isFilterButtonOn: Bool!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        isFilterButtonOn = false
        // Establecer el margen de separación para las celdas de otras secciones si lo necesitas
        tableView.separatorInsetReference = .fromAutomaticInsets
        // initial
        pageControl.currentPage = 0
        teamsList = equiposIniciales
        gamesList = partidosIniciales
        
        // tableView
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: CustomTableViewCell.reuseIdentifier, bundle: nil), forCellReuseIdentifier: CustomTableViewCell.reuseIdentifier)
        tableView.backgroundColor = blueBackgroundTableView
        
        // CollectionView
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = blueBackgroundTableView
        collectionView.register(UINib(nibName: CustomCollectionViewCell.reuseIdentifier, bundle: nil), forCellWithReuseIdentifier: CustomCollectionViewCell.reuseIdentifier)
        
        // filters
        searchBar.backgroundColor = blueBackgroundTableView
        filterButton.backgroundColor = blueBackgroundTableView
        
        let image = UIImage(systemName: "line.3.horizontal.decrease.circle")
        filterButton.setImage(image, for: .normal)
        filterButton.setTitle("", for: .normal)
        
        pageControl.backgroundColor = blueBackgroundTableView
        labelSearch.backgroundColor = blueBackgroundTableView
        headerView.backgroundColor = blueBackgroundTableView
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "DetailsSegue", let detailsPartidoVC = segue.destination as? DetailsGameViewController, let partido = sender as? Game {
            detailsPartidoVC.actualGame = partido
        }
    }
    
    // funcion para filtrar partidos por tipo de estado
    func filtrarPorEstado(_ status: StatusGame) {
        isFilterButtonOn = true
        self.gamesList = self.gamesList.filter { $0.status == status }
        self.tableView.reloadData()
    }
    
    func eliminarFiltro() {
        isFilterButtonOn = false
        self.gamesList = partidosIniciales
        self.tableView.reloadData()
    }
    
    @IBAction func filterButton(_ sender: Any) {
        gamesList = partidosIniciales
        
        let alert = UIAlertController(title: "Filtrar partidos", message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Ver acertados", style: .default, handler: { [self] action in
            self.filtrarPorEstado(.acertado)
        }))
        alert.addAction(UIAlertAction(title: "Ver errados", style: .default, handler: { [self] action in
            self.filtrarPorEstado(.errado)
        }))
        let verPendientesAction = UIAlertAction(title: "Ver pendientes", style: .default, handler: { [self] action in
            self.filtrarPorEstado(.pendiente)
        })
        verPendientesAction.setValue(redBackgroundLabelCard, forKey: "titleTextColor")
        alert.addAction(verPendientesAction)
        alert.addAction(UIAlertAction(title: "Ver jugados s/resultado", style: .default, handler: { [self] action in
            self.filtrarPorEstado(.jugado)
        }))
        alert.addAction(UIAlertAction(title: "Ver todos", style: .cancel, handler: { [self] action in
            self.eliminarFiltro()
        }))
        alert.overrideUserInterfaceStyle = .dark
        self.present(alert, animated: true, completion: nil)
    }
}

extension MainPageViewController: UITableViewDataSource , CustomTableViewCellDelegate, UITableViewDelegate{
    
    // funcion para el tap del button de la cell detalles
    func customTableViewCellDidTapButton(with partido: Game?) {
        guard let partido = partido else { return }
        performSegue(withIdentifier: "DetailsSegue", sender: partido)
    }
    
    // setup headers section
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let dictionary = Dictionary(grouping: gamesList, by: { Calendar.current.startOfDay(for: $0.dateGame ?? Date()) })
        let sortedDictionary = dictionary.sorted(by: { $0.key < $1.key }).map { (key: $0.key, value: $0.value) }
        _ = sortedDictionary.map { $0.key }
        if let firstElement = sortedDictionary[safe: section]?.value.first {
            let dateString = Date.dateFromToCustomString(date: firstElement.dateGame ?? Date())
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
    
    // numero de secciones en total dividido por fecha
    func numberOfSections(in tableView: UITableView) -> Int {
        let dictionary = Dictionary(grouping: gamesList, by: { Calendar.current.startOfDay(for: $0.dateGame ?? Date()) })
        return dictionary.count
    }
    
    // numero de filas por secciones
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let dictionary = Dictionary(grouping: gamesList, by: { Calendar.current.startOfDay(for: $0.dateGame ?? Date()) })
        let sortedDictionary = dictionary.sorted(by: { $0.key < $1.key }).map { (key: $0.key, value: $0.value) }
        let keys = sortedDictionary.map { $0.key }
        let values = keys[section]
        return dictionary[values, default: []].count
    }
    
    // inicializacion de las celdas
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CustomTableViewCell.reuseIdentifier, for: indexPath) as? CustomTableViewCell
        else { return .init()}
        
        let dictionary = Dictionary(grouping: gamesList, by: { Calendar.current.startOfDay(for: $0.dateGame ?? Date()) })
        let sortedDictionary = dictionary.sorted(by: { $0.key < $1.key }).map { (key: $0.key, value: $0.value) }
        let keys = sortedDictionary.map { $0.key }
        let values = keys[indexPath.section]
        let partidoss = dictionary[values, default: []]
        let partido = partidoss[indexPath.row]
        cell.actualGame = partido
        cell.delegate = self
        cell.moreDetailsButton.addTarget(cell, action: #selector(CustomTableViewCell.customTableViewCellDidTapButton(_:)), for: .touchUpInside)
        
        cell.setup(partido: partido)
        return cell
    }
}

extension MainPageViewController: UICollectionViewDataSource {
    
    // cantidad de imagenes en las secciones
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let cantBanners = bannersActivos.count
        pageControl.numberOfPages = cantBanners
        return cantBanners
    }
    
    // cargo los banners en cada cell
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

extension MainPageViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchEquipo = []
        if searchText.isEmpty && !isFilterButtonOn {
            gamesList = partidosIniciales
            tableView.reloadData()
            return
        }
        gamesList = filtrarPartidosPorEquipo(nombreEquipo: searchText)
        tableView.reloadData()
    }
    
    func filtrarPartidosPorEquipo(nombreEquipo: String) -> [Game] {
        return gamesList.filter { partido in
            return partido.localTeam.nameTeam.lowercased().hasPrefix(nombreEquipo.lowercased())
            || partido.rivalTeam.nameTeam.lowercased().hasPrefix(nombreEquipo.lowercased())
        }
    }
}
