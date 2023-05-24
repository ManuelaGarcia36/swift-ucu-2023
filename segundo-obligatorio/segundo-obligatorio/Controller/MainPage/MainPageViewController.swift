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
    private var gamesList: [(Date, [Game])]!
    private var gamesListForSearch: [(Date, [Game])]!
    
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
        setStructure(partidos: partidosIniciales);
        gamesListForSearch = gamesList
        
        // tableView
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: CustomTableViewCell.reuseIdentifier, bundle: nil), forCellReuseIdentifier: CustomTableViewCell.reuseIdentifier)
        tableView.register(UINib(nibName: "EmptyTableViewCell", bundle: nil), forCellReuseIdentifier: "EmptyTableViewCell")
        tableView.backgroundColor = UIColor.blueBackgroundTableView
        
        // CollectionView
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = UIColor.blueBackgroundTableView
        collectionView.register(UINib(nibName: CustomCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: CustomCollectionViewCell.identifier)
        
        // filters
        searchBar.backgroundColor = UIColor.blueBackgroundTableView
        searchBar.searchTextField.textColor = .white
        filterButton.backgroundColor = UIColor.blueBackgroundTableView
        
        let image = UIImage(systemName: "line.3.horizontal.decrease.circle")
        filterButton.setImage(image, for: .normal)
        filterButton.setTitle("", for: .normal)
        
        pageControl.backgroundColor = UIColor.blueBackgroundTableView
        labelSearch.backgroundColor = UIColor.blueBackgroundTableView
        headerView.backgroundColor = UIColor.blueBackgroundTableView
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "DetailsSegue", let detailsPartidoVC = segue.destination as? DetailsGameViewController, let partido = sender as? Game {
            detailsPartidoVC.actualGame = partido
        }
    }
    
    func setStructure(partidos: [Game]){
        let dictionary = Dictionary(grouping: partidos, by: { Calendar.current.startOfDay(for: $0.dateGame ?? Date()) })
        let sortedDictionary = dictionary.sorted(by: { $0.key < $1.key }).map { (key: $0.key, value: $0.value) }
        
        gamesList = sortedDictionary
    }
    
    // funcion para filtrar partidos por tipo de estado
    func statusFilter(_ status: StatusGame) {
        isFilterButtonOn = true
        
        let filteredGamesList = gamesListForSearch.map { (date, games) in
            let filteredGames = games.filter { game in
                return game.status == status
            }
            return (date, filteredGames)
        }
        
        gamesListForSearch = filteredGamesList.filter { !$0.1.isEmpty }
        tableView.reloadData()
    }
    
    func removeFilters() {
        isFilterButtonOn = false
        gamesListForSearch = gamesList
        tableView.reloadData()
    }
    
    @IBAction func filterButton(_ sender: Any) {
        gamesListForSearch = gamesList
        
        let alert = UIAlertController(title: "Filtrar partidos", message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Ver acertados", style: .default, handler: { [self] action in
            self.statusFilter(.acertado)
        }))
        alert.addAction(UIAlertAction(title: "Ver errados", style: .default, handler: { [self] action in
            self.statusFilter(.errado)
        }))
        let verPendientesAction = UIAlertAction(title: "Ver pendientes", style: .default, handler: { [self] action in
            self.statusFilter(.pendiente)
        })
        verPendientesAction.setValue(UIColor.redBackgroundLabelCard, forKey: "titleTextColor")
        alert.addAction(verPendientesAction)
        alert.addAction(UIAlertAction(title: "Ver jugados s/resultado", style: .default, handler: { [self] action in
            self.statusFilter(.jugado)
        }))
        alert.addAction(UIAlertAction(title: "Ver todos", style: .cancel, handler: { [self] action in
            self.removeFilters()
        }))
        alert.overrideUserInterfaceStyle = .dark
        self.present(alert, animated: true, completion: nil)
    }
    
    // valid
    func isGameListEmpty() -> Bool {
        return gamesListForSearch.contains { $0.1.isEmpty == false }
    }
}

extension MainPageViewController: UITableViewDataSource , CustomTableViewCellDelegate, UITableViewDelegate{
    
    // La modificacion se hace sobre el original
    func updateResultGame(_ index: Int, goalLocal: Int, goalVisit: Int) {
        let row = index % 1000
        let section = index / 1000
        // FIXME: BUG: Si esta con el filter button temrina actualizando otro elemento por el uso de los dos arreglos
        guard let sectionGames = gamesList[safe: section]?.1 else {
            return // Salir si la sección no existe en la lista
        }
        
        guard let game = sectionGames[safe: row] else {
            return // Salir si la fila no existe en la sección
        }
        
        var updatedGame = game // Crear una copia mutable del juego
        updatedGame.homeTeamGoals = goalLocal
        updatedGame.awayTeamGoals = goalVisit
        
        var updatedSectionGames = sectionGames // Crear una copia mutable de la lista de juegos de la sección
        updatedSectionGames[row] = updatedGame // Actualizar el juego en la lista
        
        gamesList[section].1 = updatedSectionGames // Asignar la lista de juegos actualizada a la sección correspondiente en gamesList
    }
    
    func didSelectedTheButton(_ index: Int) {
        // division to get section and row number
        let row = index % 1000
        let section = index / 1000
        let game = gamesList[safe: section]?.1[safe: row];
        guard let partido = game else { return }
        performSegue(withIdentifier: "DetailsSegue", sender: partido)
    }
    
    // setup headers section
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if let firstElement = gamesListForSearch[safe: section]?.1.first {
            let dateString = Date.dateFromToCustomString(date: firstElement.dateGame ?? Date())
            let label = UILabel()
            label.backgroundColor = UIColor.blueBackgroundTableView
            label.textColor = .white
            label.translatesAutoresizingMaskIntoConstraints = false
            label.text = dateString
            let containerView = UIView()
            containerView.addSubview(label)
            return containerView
        }
        return UIView()
    }
    
    // numero de secciones en total dividido por fecha
    func numberOfSections(in tableView: UITableView) -> Int {
        if !isGameListEmpty() {
            return 1
        } else {
            return gamesListForSearch.count
        }
    }
    
    // numero de filas por secciones
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if !isGameListEmpty() {
            return 1
        } else {
            let values = gamesListForSearch[section].1
            return values.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if !isGameListEmpty() {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "EmptyTableViewCell", for: indexPath) as? EmptyTableViewCell else {
                return UITableViewCell()
            }
            cell.setup(message: "Sin resultados encontrados")
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: CustomTableViewCell.reuseIdentifier, for: indexPath) as? CustomTableViewCell else {
                return UITableViewCell()
            }
            
            let values = gamesListForSearch[indexPath.section].1
            let partido = values[indexPath.row]
            
            cell.delegate = self
            //cell.moreDetailsButton.tag = indexPath.section * 1000 + indexPath.row // Utilizar indexPath.section y .row directamente
            cell.tag = indexPath.section * 1000 + indexPath.row // Utilizar indexPath.section y .row directamente
            
            cell.setup(partido: partido)
            return cell
        }
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
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CustomCollectionViewCell.identifier, for: indexPath) as? CustomCollectionViewCell
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
        if searchText.isEmpty && !isFilterButtonOn {
            gamesListForSearch = gamesList
            tableView.reloadData()
            return
        }
        gamesListForSearch = teamNameFilter(teamName: searchText)
        tableView.reloadData()
    }
    
    func teamNameFilter(teamName: String) -> [(Date, [Game])] {
        let filteredGamesList = gamesListForSearch.map { (date, games) in
            let filteredGames = games.filter { game in
                return game.localTeam.nameTeam.lowercased().hasPrefix(teamName.lowercased())
                || game.rivalTeam.nameTeam.lowercased().hasPrefix(teamName.lowercased())
            }
            return (date, filteredGames)
        }
        return filteredGamesList.filter { !$0.1.isEmpty }
    }
}
