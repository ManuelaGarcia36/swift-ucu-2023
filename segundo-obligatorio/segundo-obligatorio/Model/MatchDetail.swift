//
//  MatchDetailResponse.swift
//  segundo-obligatorio
//
//  Created by Manuela Garcia Lira on 3/6/23.
//
import Foundation

struct MatchDetail: Codable {
    let matchId: Int
    let date: Date
    let homeTeamName: String
    let homeTeamLogo: String
    let homeTeamGoals: Int
    let awayTeamName: String
    let awayTeamLogo: String
    let awayTeamGoals: Int
    let incidences: [Incidence]
    let predictionStatus: String
    let homeTeamPrediction: Int?
    let awayTeamPrediction: Int?
}

struct Incidence: Codable {
    let minute: Int
    let side: String
    let event: String
    let playerName: String
}
