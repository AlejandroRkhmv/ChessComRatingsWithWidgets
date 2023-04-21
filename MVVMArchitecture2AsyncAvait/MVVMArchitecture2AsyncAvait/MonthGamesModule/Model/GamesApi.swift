//
//  GamesApi.swift
//  MVVMArchitecture2AsyncAvait
//
//  Created by Александр Рахимов on 19.04.2023.
//

import Foundation


// MARK: - Games
struct GamesAPI: Codable {
    let games: [GameApi]
}

// MARK: - Game
struct GameApi: Codable {
    let pgn: String?
    let timeClass: TimeClass?
    let white: Player?
    let black: Player?

    enum CodingKeys: String, CodingKey {
        case pgn
        case timeClass = "time_class"
        case white
        case black
    }
}

// MARK: - Player
struct Player: Codable {
    let rating: Int?
    let result: Result?
    let username: String?
}

enum Result: String, Codable {
    case abandoned = "abandoned"
    case agreed = "agreed"
    case checkmated = "checkmated"
    case insufficient = "insufficient"
    case repetition = "repetition"
    case resigned = "resigned"
    case stalemate = "stalemate"
    case timeout = "timeout"
    case win = "win"
    case timevsinsufficient = "timevsinsufficient"
}

enum TimeClass: String, Codable {
    case blitz = "blitz"
    case bullet = "bullet"
    case daily = "daily"
    case rapid = "rapid"
}
