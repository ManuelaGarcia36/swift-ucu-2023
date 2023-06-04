//
//  MatchesRepository.swift
//  segundo-obligatorio
//
//  Created by Manuela Garcia Lira on 3/6/23.
//


import Foundation

class MatchesRepository {
    static let shared = MatchesRepository()
    
    let matchesService = MatchesService()
    let userRepository = UserRepository.shared // Acceder al singleton UserRepository
    
    private var matchesList: [MatchResponse]?
    private var currentBannersList: [URL]?
    
    func setup(completion: @escaping (Result<Void, Error>) -> Void) {
        guard let token = userRepository.getUserResponse()?.token else {
            print("No se encontró un token válido")
            completion(.failure(CustomError.invalidToken))
            return
        }
        
        self.getBanners(token: token) { result in
            switch result {
            case .success(let banners):
                self.currentBannersList = banners
                completion(.success(()))
            case .failure(let error):
                completion(.failure(error))
            }
        }
        
        self.loadMatchesData(token: token) { result in
            switch result {
            case .success(let matches):
                self.matchesList = matches
                completion(.success(()))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func getBanners(token: String, completion: @escaping (Result<[URL], Error>) -> Void) {
        matchesService.getBanners(token: token) { result in
            switch result {
            case .success(let bannerURLs):
                self.currentBannersList = bannerURLs
                completion(.success(bannerURLs))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func loadMatchesData(token: String, completion: @escaping (Result<[MatchResponse], Error>) -> Void) {
        matchesService.loadMatchesData(token: token) { result in
            switch result {
            case .success(let matches):
                self.matchesList = matches
                completion(.success(matches))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func getDetailsMatchesData(token: String, matchId: Int, completion: @escaping (Result<MatchDetailResponse, Error>) -> Void) {
        matchesService.getDetailsMatchesData(token: token, matchId: matchId, completion: completion)
    }
}
