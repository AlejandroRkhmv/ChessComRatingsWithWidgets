//
//  Game.swift
//  MVVMArchitecture2AsyncAvait
//
//  Created by Александр Рахимов on 19.04.2023.
//

import Foundation

class Game: Identifiable {
    var uuid: UUID?
    let pgn: String?
    let type: String?
    let whitePlayerName: String?
    let blackPlayerName: String?
    let whitePlayerResult: String?
    let blackPlayerResult: String?
    let whitePlayerRating: Int?
    let blackPlayerRating: Int?
    
    init(gamesApi: GameApi) {
        self.pgn = gamesApi.pgn
        self.type = gamesApi.timeClass?.rawValue
        self.whitePlayerName = gamesApi.white?.username
        self.blackPlayerName = gamesApi.black?.username
        self.whitePlayerResult = gamesApi.white?.result?.rawValue
        self.blackPlayerResult = gamesApi.black?.result?.rawValue
        self.whitePlayerRating = gamesApi.white?.rating
        self.blackPlayerRating = gamesApi.black?.rating
    }
}
