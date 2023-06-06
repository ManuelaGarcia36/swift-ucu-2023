//
//  MatchService.swift
//  segundo-obligatorio
//
//  Created by Manuela Garcia Lira on 5/6/23.
//

import Foundation

class MatchService {
    static let shared = MatchService()
    
    let userRepository = UserRepository.shared
    var currentUserToken: String!
    let baseUrl: String = "https://api.penca.inhouse.decemberlabs.com/api/v1"
    
    private init() {
       setupCurrentUserToken()
   }

   private func setupCurrentUserToken() {
       guard let user = userRepository.getUserResponse() else {
           return
       }
       self.currentUserToken = user.token
   }
    
    func fetchBannerUrls(completion: @escaping ([String]?, Error?) -> Void) {
        var url = baseUrl+"/files"
        APIClient.shared.requestBase(urlString: url,
                                     method: .get,
                                     params: [:],
                                     token: currentUserToken,
                                     sessionPolicy: .privateDomain) { (result: Result<Dictionary<String, [String]>, Error>) in
            switch result {
            case .success(let response):
                if let bannerURLs = response["bannerURLs"] {
                    completion(bannerURLs, nil)
                } else {
                    completion(nil, NetworkError.customError(message: "Data error to get response list"))
                }
            case .failure(let error):
                completion(nil, NetworkError.customError(message: "\(error)"))
            }
        }
    }
    
    func fetchMatchesData(completion: @escaping ([(Date, [Match])]?, Error?) -> Void) {
        var url = baseUrl+"/match?page=1&pageSize=30&order=ASC"
        APIClient.shared.requestBase(urlString: url,
                                     method: .get,
                                     params: [:],
                                     token: currentUserToken,
                                     sessionPolicy: .privateDomain) { (result: Result<MatchResponseWrapper, Error>) in
            switch result {
            case .success(let data):
                let dictionary = Dictionary(grouping: data.matches, by: { Calendar.current.startOfDay(for: $0.date ) })
                let sortedDictionary = dictionary.sorted(by: { $0.key < $1.key }).map { (key: $0.key, value: $0.value) }
                completion(sortedDictionary, nil)
            case .failure(let error):
                completion(nil, NetworkError.customError(message: "Error: \(error)"))
            }
        }
    }
    
    func fetchDetailsMatchById(matchId: Int, completion: @escaping (MatchDetail?, Error?) -> Void) {
        var url = baseUrl+"/match/\(matchId)"
        APIClient.shared.requestBase(urlString: url,
                                     method: .get,
                                     params: [:],
                                     token: currentUserToken,
                                     sessionPolicy: .privateDomain) { (result: Result<MatchDetail, Error>) in
            switch result {
            case .success(let data):
                completion(data, nil)
            case .failure(let error):
                completion(nil, NetworkError.customError(message: "Error: \(error)"))
            }
        }
    }
    
    func patchMatchWithAPI(matchId: Int, goalsHome: Int, goalsAway: Int, completion: @escaping (Error?) -> Void) {
        let params: [String: Any] = [
            "homeGoals": goalsHome,
            "awayGoals": goalsAway
        ]
        var url = baseUrl+"/match/\(matchId)"
        APIClient.shared.requestBase(urlString: url,
                                     method: .patch,
                                     params: params,
                                     token: currentUserToken,
                                     sessionPolicy: .privateDomain) { (result: Result<Dictionary<String, Int>, Error>) in
            switch result {
            case .success:
                completion(nil)
            case .failure(let error):
                completion(NetworkError.customError(message: "Error: \(error)"))
            }
        }
    }
}
