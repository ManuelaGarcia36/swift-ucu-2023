//
//  MatchService.swift
//  segundo-obligatorio
//
//  Created by Manuela Garcia Lira on 3/6/23.
//

import Foundation

class MatchesService {
    let apiClient = APIClient.shared

    func getBanners(token: String, completion: @escaping (Result<[String], Error>) -> Void) {
        apiClient.requestBase(urlString: "https://api.penca.inhouse.decemberlabs.com/api/v1/files",
                              method: .get,
                              params: [:],
                              token: token,
                              sessionPolicy: .privateDomain) { (result: Result<Dictionary<String, [String]>, Error>) in
            switch result {
            case .success(let imageUrls):
                if let bannerURLs = imageUrls["bannerURLs"] {
                   completion(.success(bannerURLs))
               } else {
                   completion(.success([]))
               }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func getMatchesData(token: String, completion: @escaping (Result<[MatchResponse], Error>) -> Void) {
        apiClient.requestBase(urlString: "https://api.penca.inhouse.decemberlabs.com/api/v1/match/?page=1&pageSize=30&order=ASC",
                              method: .get,
                              params: [:],
                              token: token,
                              sessionPolicy: .privateDomain) { (result: Result<MatchResponseWrapper, Error>) in
            switch result {
            case .success(let data):
                completion(.success(data.matches))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func getDetailsMatchesData(token: String, matchId: Int, completion: @escaping (Result<MatchDetailResponse, Error>) -> Void) {
        apiClient.requestBase(urlString: "https://api.penca.inhouse.decemberlabs.com/api/v1/match/\(matchId)",
                              method: .get,
                              params: [:],
                              token: token,
                              sessionPolicy: .privateDomain) { (result: Result<MatchDetailResponse, Error>) in
            switch result {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
