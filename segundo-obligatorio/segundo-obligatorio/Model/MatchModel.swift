//
//  MatchModel.swift
//  segundo-obligatorio
//
//  Created by Manuela Garcia Lira on 5/6/23.
//

import Foundation


class MatchModel: ObservableObject {
   
    @Published var matchesDictionaryList: [(Date, [Match])] = [:]
    
    init() {
        loadMatchesDataWithAPI()
    }
    func loadMatchesDataWithAPI() {
        APIClient.shared.requestBase(urlString: "https://api.penca.inhouse.decemberlabs.com/api/v1/match/?page=1&pageSize=30&order=ASC",
                                     method: .get,
                                     params: [:],
                                     token: currentUser.token,
                                     sessionPolicy: .privateDomain) { (result: Result<MatchResponseWrapper, Error>) in
            switch result {
            case .success(let data):
    
                let dictionary = Dictionary(grouping: data.matches, by: { Calendar.current.startOfDay(for: $0.date ) })
                        let sortedDictionary = dictionary.sorted(by: { $0.key < $1.key }).map { (key: $0.key, value: $0.value) }
                    
                self.matchesDictionaryList = sortedDictionary
                //self.matchesFilterDictionaryList = sortedDictionary
                // self.tableView.reloadData()
            case .failure(let error):
                print("Error:", error)
            }
        }
    }
   
}
