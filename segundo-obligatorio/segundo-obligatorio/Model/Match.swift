//
//  MatchResponse.swift
//  segundo-obligatorio
//
//  Created by Manuela Garcia Lira on 31/5/23.
//

import Foundation
import UIKit

struct MatchResponseWrapper: Codable {
    let matches: [Match]
}

struct Match: Codable {
    let matchId: Int
    let date: Date
    let homeTeamId: Int
    let homeTeamName: String
    let homeTeamLogo: String
    let awayTeamId: Int
    let awayTeamName: String
    let awayTeamLogo: String
    let status: Status
    var homeTeamGoals: Int?
    var awayTeamGoals: Int?
    var predictedHomeGoals: Int?
    var predictedAwayGoals: Int?
    
    private enum CodingKeys: String, CodingKey {
        case matchId, date, homeTeamId, homeTeamName, homeTeamLogo, awayTeamId, awayTeamName, awayTeamLogo, status, homeTeamGoals, awayTeamGoals, predictedHomeGoals, predictedAwayGoals
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        matchId = try container.decode(Int.self, forKey: .matchId)
        homeTeamId = try container.decode(Int.self, forKey: .homeTeamId)
        homeTeamName = try container.decode(String.self, forKey: .homeTeamName)
        homeTeamLogo = try container.decode(String.self, forKey: .homeTeamLogo)
        awayTeamId = try container.decode(Int.self, forKey: .awayTeamId)
        awayTeamName = try container.decode(String.self, forKey: .awayTeamName)
        awayTeamLogo = try container.decode(String.self, forKey: .awayTeamLogo)
        status = try container.decode(Status.self, forKey: .status)
        if status == .pending {
         predictedHomeGoals = try container.decodeIfPresent(Int.self, forKey: .predictedHomeGoals)
         predictedAwayGoals = try container.decodeIfPresent(Int.self, forKey: .predictedAwayGoals)
        } else {
         homeTeamGoals = try container.decodeIfPresent(Int.self, forKey: .homeTeamGoals)
         awayTeamGoals = try container.decodeIfPresent(Int.self, forKey: .awayTeamGoals)
        }
        date = try container.decodeIfPresent(Date.self, forKey: .date) ?? Date() // FIXME
    }
}

extension DateFormatter {
  static let iso8601Full: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
    formatter.calendar = Calendar(identifier: .iso8601)
    formatter.timeZone = TimeZone(secondsFromGMT: 0)
    formatter.locale = Locale(identifier: "en_US_POSIX")
    return formatter
  }()
}
