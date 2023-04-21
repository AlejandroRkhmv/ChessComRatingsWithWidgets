//
//  CorrespondencePartyApi.swift
//  MVVMArchitecture2AsyncAvait
//
//  Created by Александр Рахимов on 19.04.2023.
//

import Foundation

// MARK: - Games
struct CorrespondencePartyApi: Codable {
    let games: [Correspondence]
}

// MARK: - Game
struct Correspondence: Codable {
    let url: String?
    let moveBy: Int?
    let pgn, timeControl: String?
    let lastActivity: Int?
    let rated: Bool?
    let turn, fen: String?
    let startTime: Int?
    let timeClass, rules: String?
    let white, black: String?

    enum CodingKeys: String, CodingKey {
        case url
        case moveBy = "move_by"
        case pgn
        case timeControl = "time_control"
        case lastActivity = "last_activity"
        case rated, turn, fen
        case startTime = "start_time"
        case timeClass = "time_class"
        case rules, white, black
    }
}
