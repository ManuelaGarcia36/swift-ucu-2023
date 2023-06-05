//
//  MatchesRepository.swift
//  segundo-obligatorio
//
//  Created by Manuela Garcia Lira on 3/6/23.
//


import Foundation

class MatchesRepository: ObservableObject {
    
    let userRepository = UserRepository.shared
    let matchesService = MatchesService()
    
    @Published var matchesList: [MatchResponse]?
    private var currentBannersList: [String]?
    
    
    init() {
        loadMatchesData()
            //getBanners()
    }
    
   
    
    func loadMatchesData() {
        guard let token = userRepository.getUserResponse()?.token else {
            return
        }
        
        matchesService.getMatchesData(token: token) { result in
            switch result {
            case .success(let matches):
                self.matchesList = matches
               // completion(.success(()))
            case .failure(let error):
                print("Manu error: \(error)")
            }
        }
    }
    
    func getDetailsMatchesData(token: String, matchId: Int, completion: @escaping (Result<MatchDetailResponse, Error>) -> Void) {
        matchesService.getDetailsMatchesData(token: token, matchId: matchId, completion: completion)
    }

}
