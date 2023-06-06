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
    
    let matchService = MatchService.shared
    
    private var isFilterButtonOn: Bool = false
    private var filterType: Status?
    
    private var bannerStringUrl: [String] = []
    private var matchesDictionaryList: [(Date, [Match])]! //dictionary
    private var matchesDictionaryListWithFilters: [(Date, [Match])]! // copy
    
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
        
        let imageFilterButton = UIImage(systemName: "line.3.horizontal.decrease.circle")
        filterButton.setImage(imageFilterButton, for: .normal)
        filterButton.setTitle("", for: .normal)
        filterButton.tintColor = UIColor.lightBlueTableViewDetails
        
        pageControl.backgroundColor = UIColor.blueBackgroundTableView
        labelSearch.backgroundColor = UIColor.blueBackgroundTableView
        headerView.backgroundColor = UIColor.blueBackgroundTableView
        
        // Initial data
        setup()
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
    
    func setup() {
        matchService.fetchBannerUrls { [weak self] (bannerURLs, error) in
            if let error = error {
                print("Error getting image URLs: \(error)")
            } else if let bannerURLs = bannerURLs {
                self?.bannerStringUrl = bannerURLs
                self?.collectionView.reloadData()
            }
        }
        
        matchService.fetchMatchesData { [weak self] (data, error) in
            if let error = error {
                print("Error getting match data: \(error)")
            } else if let dictionary = data {
                self?.matchesDictionaryList = dictionary
                self?.matchesDictionaryListWithFilters = dictionary
                self?.tableView.reloadData()
            }
        }
    }
    
    func filterByStatus() {
        matchesDictionaryListWithFilters = matchesDictionaryList // original server list
        isFilterButtonOn = true
        self.filterButton.tintColor = UIColor.red
        let filteredGamesList = matchesDictionaryListWithFilters.map { (date, games) in
            let filteredGames = games.filter { game in
                return game.status == filterType
            }
            return (date, filteredGames)
        }
        matchesDictionaryListWithFilters = filteredGamesList.filter { !$0.1.isEmpty }
        tableView.reloadData()
    }
    
    func reloadDataFromServer() {
        matchService.fetchMatchesData { [weak self] (data, error) in
            if let error = error {
                print("Error getting match data: \(error)")
            } else if let dictionary = data {
                self?.matchesDictionaryList = dictionary
                self?.matchesDictionaryListWithFilters = dictionary
                self?.tableView.reloadData()
            }
        }
        removeFilters()
    }
    
    func removeFilters() {
        isFilterButtonOn = false
        filterType = nil
        self.filterButton.tintColor = UIColor.lightBlueTableViewDetails
        matchesDictionaryListWithFilters = matchesDictionaryList
        tableView.reloadData()
    }
    
    @IBAction func filterButton(_ sender: Any) {
        matchesDictionaryListWithFilters = matchesDictionaryList
        
        let alert = UIAlertController(title: "Filtrar partidos", message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Ver acertados", style: .default, handler: { [self] action in
            self.filterType = .correct
            self.filterByStatus()
        }))
        alert.addAction(UIAlertAction(title: "Ver errados", style: .default, handler: { [self] action in
            self.filterType = .incorrect
            self.filterByStatus()
        }))
        let verPendientesAction = UIAlertAction(title: "Ver pendientes", style: .default, handler: { [self] action in
            self.filterType = .pending
            self.filterByStatus()
        })
        verPendientesAction.setValue(UIColor.redBackgroundLabelCard, forKey: "titleTextColor")
        alert.addAction(verPendientesAction)
        alert.addAction(UIAlertAction(title: "Ver jugados s/resultado", style: .default, handler: { [self] action in
            self.filterType = .not_predicted
            self.filterByStatus()
        }))
        alert.addAction(UIAlertAction(title: "Ver todos", style: .cancel, handler: { [self] action in
            self.removeFilters()
        }))
        alert.overrideUserInterfaceStyle = .dark
        self.present(alert, animated: true, completion: nil)
    }
    
    func isMatchesListEmpty() -> Bool {
        guard let list = matchesDictionaryListWithFilters else {
            return true
        }
        // searchBar set Optional([]) in the case of empty text
        if let array = list as? [(Date, [Match])], array.isEmpty {
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
                print("Error trying to delete user: \(error)")
            }
        }
    }
}

extension MainPageViewController: CustomTableViewCellDelegate {
    
    func didSelectedTheButton(cell: UITableViewCell) {
        guard let indexPath = tableView.indexPath(for: cell) else { return }
        let sectionIndex = indexPath.section
        let rowIndex = indexPath.row
        guard let list = matchesDictionaryList else { return }
        guard sectionIndex >= 0 && sectionIndex < list.count else { return }
        let section = list[sectionIndex] // sección correspondiente
        guard rowIndex >= 0 && rowIndex < section.1.count else { return }
        let matchSelected = section.1[rowIndex] // fila correspondiente
        
        matchService.fetchDetailsMatchById(matchId: matchSelected.matchId) { [weak self] (matchDetail, error) in
            if let error = error {
                print("Unexpected error: \(error)")
            } else if let matchDetail = matchDetail {
                let storyboard = UIStoryboard(name: "MainPageScreen", bundle: nil)
                let destinationVC = storyboard.instantiateViewController(withIdentifier: "DetailsGameID") as! DetailsGameViewController
                destinationVC.matchDetails = matchDetail
                destinationVC.matchSelected = matchSelected
                self?.navigationController?.pushViewController(destinationVC, animated: true)
            }
        }
    }
    
    func updateResultGame(cell: UITableViewCell, goalLocal: Int, goalVisit: Int) {
        guard let indexPath = tableView.indexPath(for: cell) else {
            return
        }
        let sectionIndex = indexPath.section
        let rowIndex = indexPath.row
        guard sectionIndex >= 0 && sectionIndex < matchesDictionaryListWithFilters.count else {
            return // invalid
        }
        let section = matchesDictionaryListWithFilters[sectionIndex] // get section index
        guard rowIndex >= 0 && rowIndex < section.1.count else { // validate index
            return
        }
        let match = section.1[rowIndex]
        matchService.patchMatchWithAPI(matchId: match.matchId, goalsHome: goalLocal, goalsAway: goalVisit) { [weak self] (error) in
            if let error = error {
                print("Failed to update match: \(error)")
                self?.reloadDataFromServer() //FIXME: not found case with filters
            } else {
                print("Successful update")
                self?.reloadDataFromServer() //FIXME: not found case with filters
            }
        }
    }
}

extension MainPageViewController: UITableViewDataSource , UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if isMatchesListEmpty() { return 1 } else {
            return matchesDictionaryListWithFilters.count
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isMatchesListEmpty() { return 1 } else {
            let values = matchesDictionaryListWithFilters[section].1
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
            let values = matchesDictionaryListWithFilters[indexPath.section].1
            let match = values[indexPath.row]
            cell.delegate = self
            cell.setup(match: match)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if isMatchesListEmpty() { return "" }
        let entry = matchesDictionaryListWithFilters[section]
        let date = entry.0 // key of element
        return DateFormatter.dateFromToCustomString(date: date)
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
        let cantBanners = bannerStringUrl.count
        pageControl.numberOfPages = cantBanners
        return cantBanners
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CustomCollectionViewCell.identifier, for: indexPath) as? CustomCollectionViewCell
        else { return .init()}
        let elemt = bannerStringUrl[indexPath.row]
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
            matchesDictionaryListWithFilters = matchesDictionaryList
        } else if searchText.isEmpty && isFilterButtonOn {
            filterByStatus()
        }
        matchesDictionaryListWithFilters = filterByTeamName(teamName: searchText)
        tableView.reloadData()
    }
    
    func filterByTeamName(teamName: String) -> [(Date, [Match])] {
        let filteredGamesList = matchesDictionaryListWithFilters.map { (date, games) in
            let filteredGames = games.filter { game in
                return game.homeTeamName.lowercased().hasPrefix(teamName.lowercased())
                || game.awayTeamName.lowercased().hasPrefix(teamName.lowercased())
            }
            return (date, filteredGames)
        }
        return filteredGamesList.filter { !$0.1.isEmpty }
    }
}
