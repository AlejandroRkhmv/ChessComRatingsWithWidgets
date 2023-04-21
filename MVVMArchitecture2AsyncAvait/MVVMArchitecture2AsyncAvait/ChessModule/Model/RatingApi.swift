//
//  ChessRatingModel.swift
//  MVVMArchitecture2AsyncAvait
//
//  Created by Александр Рахимов on 15.04.2023.
//

import Foundation



// MARK: - UserRatingsAPI
struct RatingAPI: Codable {
    let chessDaily: ChessDaily?
    let chessRapid: Chess?
    let chessBullet: Chess?
    let chessBlitz: Chess?
    let fide: Int?
    let tactics: Tactics?
    let puzzleRush: PuzzleRush?

    enum CodingKeys: String, CodingKey {
        case chessDaily = "chess_daily"
        case chessRapid = "chess_rapid"
        case chessBullet = "chess_bullet"
        case chessBlitz = "chess_blitz"
        case fide, tactics
        case puzzleRush = "puzzle_rush"
    }
}

// MARK: - Chess
struct Chess: Codable {
    let last: Last?
    let best: ChessBest?
    let record: ChessRecord?
}

// MARK: - ChessBlitzBest
struct ChessBest: Codable {
    let rating, date: Int
    let game: String
}

// MARK: - Last
struct Last: Codable {
    let rating, date, rd: Int
}

// MARK: - ChessBlitzRecord
struct ChessRecord: Codable {
    let win, loss, draw: Int
}

//// MARK: - ChessBullet
//struct ChessBullet: Codable {
//    let last: Last
//    let best: ChessBlitzBest?
//    let record: ChessBlitzRecord
//}

// MARK: - ChessDaily
struct ChessDaily: Codable {
    let last: Last?
    let best: ChessBest?
    let record: ChessDailyRecord?
}

// MARK: - ChessDailyRecord
struct ChessDailyRecord: Codable {
    let win, loss, draw, timePerMove: Int
    let timeoutPercent: Int

    enum CodingKeys: String, CodingKey {
        case win, loss, draw
        case timePerMove = "time_per_move"
        case timeoutPercent = "timeout_percent"
    }
}

// MARK: - PuzzleRush
struct PuzzleRush: Codable {
    let best: PuzzleRushBest?
}

// MARK: - PuzzleRushBest
struct PuzzleRushBest: Codable {
    let totalAttempts, score: Int

    enum CodingKeys: String, CodingKey {
        case totalAttempts = "total_attempts"
        case score
    }
}

// MARK: - Tactics
struct Tactics: Codable {
    let highest, lowest: Est?
}

// MARK: - Est
struct Est: Codable {
    let rating, date: Int
}
