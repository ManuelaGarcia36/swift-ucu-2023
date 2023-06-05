//
//  MainPageViewController.swift
//  primer-obligatorio
//
//  Created by Manuela Garcia Lira on 1/5/23.
//

import Foundation
import UIKit


class MainPageViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var labelSearch: UILabel!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var filterButton: UIButton!
    @IBOutlet weak var deleteUserButton: UIButton!
    
    let userRepository = UserRepository.shared
    var currentUser: UserResponse!

    var bannerURLs: [String] = []
    private var isFilterButtonOn: Bool = false
    private var filterType: StatusGame?
    
    private var matches: [MatchResponse]? // data
    private var matchesDictionaryList: [(Date, [MatchResponse])]! //dictionary
    private var matchesFilterDictionaryList: [(Date, [MatchResponse])]! // copy
    
    override func viewDidLoad() {
        super.viewDidLoad()
        isFilterButtonOn = false
        pageControl.currentPage = 0
    
        // TableView
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: CustomTableViewCell.reuseIdentifier, bundle: nil), forCellReuseIdentifier: CustomTableViewCell.reuseIdentifier)
        tableView.register(UINib(nibName: EmptyTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: EmptyTableViewCell.identifier)
        tableView.backgroundColor = UIColor.blueBackgroundTableView
        
        // CollectionView
        collectionView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = UIColor.blueBackgroundTableView
        collectionView.register(UINib(nibName: CustomCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: CustomCollectionViewCell.identifier)
        
        // Filters
        searchBar.backgroundColor = UIColor.blueBackgroundTableView
        searchBar.searchTextField.textColor = .white
        filterButton.backgroundColor = UIColor.blueBackgroundTableView
        
        let image = UIImage(systemName: "line.3.horizontal.decrease.circle")
        filterButton.setImage(image, for: .normal)
        filterButton.setTitle("", for: .normal)
        filterButton.tintColor = UIColor.lightBlueTableViewDetails
        
        pageControl.backgroundColor = UIColor.blueBackgroundTableView
        labelSearch.backgroundColor = UIColor.blueBackgroundTableView
        headerView.backgroundColor = UIColor.blueBackgroundTableView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Ocultar el botón de retroceso en la barra de navegacion de esta vista
        // TODO: Agregar un boton que sea para mirar el perfil y permitirle hacer el logout o delete user
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // Restaurar la visibilidad del botón de retroceso en la barra de navegación para otras pantallas como la de detalles
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    func setup() {
        guard let user = userRepository.getUserResponse() else {
            print("No se encontró user válido")
            return
        }
        currentUser = user;
        getBanners();
        refreshTable();
    }
    
    func getBanners() {
        APIClient.shared.requestBase(urlString: "https://api.penca.inhouse.decemberlabs.com/api/v1/files",
                                     method: .get,
                                     params: [:],
                                     token: currentUser.token,
                                     sessionPolicy: .privateDomain) { (result: Result<Dictionary<String, [String]>, Error>) in
            switch result {
            case .success(let response):
                if let bannerURLs = response["bannerURLs"] {
                    self.bannerURLs = bannerURLs
                    self.collectionView.reloadData()
                } else {
                    print("No se encontró la clave 'bannerURLs' en la respuesta")
                }
            case .failure(let error):
                print("Error al obtener las URLs de las imágenes:", error)
            }
        }
    }
    
    func loadMatchesDataWithAPI() {
        APIClient.shared.requestBase(urlString: "https://api.penca.inhouse.decemberlabs.com/api/v1/match/?page=1&pageSize=30&order=ASC",
                                     method: .get,
                                     params: [:],
                                     token: currentUser.token,
                                     sessionPolicy: .privateDomain) { (result: Result<MatchResponseWrapper, Error>) in
            switch result {
            case .success(let data):
                self.matches = data.matches
                self.parseDictionarySortedMatches()
                self.tableView.reloadData()
            case .failure(let error):
                print("Error:", error)
            }
        }
    }
    
    func getDetailsMatchesDataWithAPI(matchId: Int, completion: @escaping (Result<MatchDetailResponse, Error>) -> Void) {
        APIClient.shared.requestBase(urlString: "https://api.penca.inhouse.decemberlabs.com/api/v1/match/\(matchId)",
                                     method: .get,
                                     params: [:],
                                     token: currentUser.token,
                                     sessionPolicy: .privateDomain) { (result: Result<MatchDetailResponse, Error>) in
            completion(result)
        }
    }
    
    func parseDictionarySortedMatches(){
        guard let matchesList = matches else {
            return
        }
        let dictionary = Dictionary(grouping: matchesList, by: { Calendar.current.startOfDay(for: $0.date ) })
        let sortedDictionary = dictionary.sorted(by: { $0.key < $1.key }).map { (key: $0.key, value: $0.value) }
    
        matchesDictionaryList = sortedDictionary
        matchesFilterDictionaryList = matchesDictionaryList
    }
    
    func statusFilter() {
        matchesFilterDictionaryList = matchesDictionaryList // siempre parte de la lista original
        isFilterButtonOn = true
        self.filterButton.tintColor = UIColor.red
        let filteredGamesList = matchesFilterDictionaryList.map { (date, games) in
            let filteredGames = games.filter { game in
                return game.status == filterType
            }
            return (date, filteredGames)
        }
        matchesFilterDictionaryList = filteredGamesList.filter { !$0.1.isEmpty }
        tableView.reloadData()
    }
    
    func removeFilters() {
        isFilterButtonOn = false
        filterType = nil
        self.filterButton.tintColor = UIColor.lightBlueTableViewDetails
        matchesFilterDictionaryList = matchesDictionaryList
        tableView.reloadData()
    }
    
    @IBAction func filterButton(_ sender: Any) {
        matchesFilterDictionaryList = matchesDictionaryList
        
        let alert = UIAlertController(title: "Filtrar partidos", message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Ver acertados", style: .default, handler: { [self] action in
            self.filterType = .correct
            self.statusFilter()
        }))
        alert.addAction(UIAlertAction(title: "Ver errados", style: .default, handler: { [self] action in
            self.filterType = .incorrect
            self.statusFilter()
        }))
        let verPendientesAction = UIAlertAction(title: "Ver pendientes", style: .default, handler: { [self] action in
            self.filterType = .pending
            self.statusFilter()
        })
        verPendientesAction.setValue(UIColor.redBackgroundLabelCard, forKey: "titleTextColor")
        alert.addAction(verPendientesAction)
        alert.addAction(UIAlertAction(title: "Ver jugados s/resultado", style: .default, handler: { [self] action in
            self.filterType = .not_predicted
            self.statusFilter()
        }))
        alert.addAction(UIAlertAction(title: "Ver todos", style: .cancel, handler: { [self] action in
            self.removeFilters()
        }))
        alert.overrideUserInterfaceStyle = .dark
        self.present(alert, animated: true, completion: nil)
    }
    
    func isMatchesListEmpty() -> Bool {
        guard let list = matchesFilterDictionaryList else {
            return true
        }
        // searchBar set Optional([]) in the case of empty text
        if let array = list as? [(Date, [MatchResponse])], array.isEmpty {
            return true
        }
        
        return list.contains { $0.1.isEmpty == true }
    }
    
    @IBAction func deleteUserWithAPI(_ sender: Any) {
        AuthService.shared.deleteUser { [weak self] (result) in
            switch result {
            case .success(let data):
                let storyboard = UIStoryboard(name: "LoginScreen", bundle: nil)
                let destinationVC = storyboard.instantiateViewController(withIdentifier: "ViewControllerID") as! ViewController
                self?.navigationController?.pushViewController(destinationVC, animated: true)
            case .failure(let error):
                print("Error:", error)
            }
        }
    }
    
    func refreshTable() {
        loadMatchesDataWithAPI()
        
        // FIXME
        //removeFilters()
    }
    
    func patchMatchWithAPI(matchId: Int, goalsHome: Int, goalsAway: Int) {
        let params: [String: Any] = [
            "homeGoals": goalsHome,
            "awayGoals": goalsAway
        ]
        
        APIClient.shared.requestBase(urlString: "https://api.penca.inhouse.decemberlabs.com/api/v1/match/\(matchId)",
                                     method: .patch,
                                     params: params,
                                     token: currentUser.token,
                                     sessionPolicy: .privateDomain) { (result: Result<Dictionary<String, Int>, Error>) in
            switch result {
            case .success(let data):
                print("Succes patch: \(data)")
                self.refreshTable()
            case .failure(let error):
                print("Error in patch:", error)
            }
        }
    

    }
}

extension MainPageViewController: CustomTableViewCellDelegate {
    
    func didSelectedTheButton(cell: UITableViewCell) {
        guard let indexPath = tableView.indexPath(for: cell) else { return }
        let sectionIndex = indexPath.section
        let rowIndex = indexPath.row
        guard sectionIndex >= 0 && sectionIndex < matchesDictionaryList.count else { return }
        let section = matchesDictionaryList[sectionIndex] // sección correspondiente
        guard rowIndex >= 0 && rowIndex < section.1.count else { return }
        let matchSelected = section.1[rowIndex] // fila correspondiente
        getDetailsMatchesDataWithAPI(matchId: matchSelected.matchId) { result in
            switch result {
            case .success(let details):
                let storyboard = UIStoryboard(name: "MainPageScreen", bundle: nil)
                let destinationVC = storyboard.instantiateViewController(withIdentifier: "DetailsGameID") as! DetailsGameViewController
                destinationVC.matchDetails = details
                destinationVC.matchSelected = matchSelected
                self.navigationController?.pushViewController(destinationVC, animated: true)
            case .failure(let error):
                print("Error:", error)
            }
        }
    }
    
    func updateResultGame(cell: UITableViewCell, goalLocal: Int, goalVisit: Int) {
         guard let indexPath = tableView.indexPath(for: cell) else {
             return
         }
         let sectionIndex = indexPath.section
         let rowIndex = indexPath.row
         guard sectionIndex >= 0 && sectionIndex < matchesFilterDictionaryList.count else {
             return // invalido
         }
         let section = matchesFilterDictionaryList[sectionIndex] // Obtener la sección correspondiente al índice
         guard rowIndex >= 0 && rowIndex < section.1.count else { // Verificar si el índice de fila es válido
             return
         }
         let match = section.1[rowIndex]  // Obtener el elemento correspondiente al índice de fila
         print("match: \(match) ")
         print("elemento a actualizar: \(goalLocal) \(goalVisit) ")
        
         var updatedGame = match // Crear una copia mutable del juego
         updatedGame.homeTeamGoals = goalLocal
         updatedGame.awayTeamGoals = goalVisit
         
         patchMatchWithAPI(matchId: match.matchId, goalsHome: goalLocal, goalsAway: goalVisit)
         
    }
}

extension MainPageViewController: UITableViewDataSource , UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if isMatchesListEmpty() {
            return 1
        } else {
            return matchesFilterDictionaryList.count
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isMatchesListEmpty() {
            return 1
        } else {
            let values = matchesFilterDictionaryList[section].1
            return values.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if isMatchesListEmpty() {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: EmptyTableViewCell.identifier, for: indexPath) as? EmptyTableViewCell else {
                return UITableViewCell()
            }
            cell.setup(message: "Sin resultados encontrados")
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: CustomTableViewCell.reuseIdentifier, for: indexPath) as? CustomTableViewCell else {
                return UITableViewCell()
            }
            let values = matchesFilterDictionaryList[indexPath.section].1
            let partido = values[indexPath.row]
            cell.delegate = self
            cell.setup(match: partido)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if isMatchesListEmpty() {
            return ""
        }
        let entry = matchesFilterDictionaryList[section]
        let date = entry.0 // Acceder a la clave del elemento
        return Date.dateFromToCustomString(date: date)
    }

    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let headerView = view as? UITableViewHeaderFooterView else {
            return
        }
        
        headerView.tintColor = UIColor.blueBackgroundTableView
        headerView.textLabel?.textColor = UIColor.white
    }

}

extension MainPageViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let cantBanners = bannerURLs.count
        pageControl.numberOfPages = cantBanners
        return cantBanners
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CustomCollectionViewCell.identifier, for: indexPath) as? CustomCollectionViewCell
        else { return .init()}
        let elemt = bannerURLs[indexPath.row]
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
            matchesFilterDictionaryList = matchesDictionaryList
            
        } else if searchText.isEmpty && isFilterButtonOn {
            statusFilter()
        }
        matchesFilterDictionaryList = filterByTeamName(teamName: searchText)
        tableView.reloadData()
    }
    
    func filterByTeamName(teamName: String) -> [(Date, [MatchResponse])] {
        let filteredGamesList = matchesFilterDictionaryList.map { (date, games) in
            let filteredGames = games.filter { game in
                return game.homeTeamName.lowercased().hasPrefix(teamName.lowercased())
                || game.awayTeamName.lowercased().hasPrefix(teamName.lowercased())
            }
            return (date, filteredGames)
        }
        return filteredGamesList.filter { !$0.1.isEmpty }
    }
}
