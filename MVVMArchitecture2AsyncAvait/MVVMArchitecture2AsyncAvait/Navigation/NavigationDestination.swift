//
//  NavigationDestination.swift
//  MVVMArchitecture2AsyncAvait
//
//  Created by Александр Рахимов on 15.04.2023.
//

import Foundation
import SwiftUI

enum NavigationDestination: Hashable {
    case chessView(userName: String)
    case archive(userName: String)
    case gamesForMonth(urlString: String)
    case movesInGame(moves: String, playerOne: String, playerTwo: String)
    case correspondenceView(userName: String)
}

// MARK: - View + Navigation
extension View {
    func withNavigationDestination() -> some View {
        self.navigationDestination(for: NavigationDestination.self) { destination in
            let di = Dependencies()
            switch destination {
            case .chessView(let userName):
                ChessView(chessViewModel: di.createChessViewModel(), userName: userName)
            case .archive(let userName):
                ArchiveView(archiveViewModel: di.createArchiveViewModel(), userName: userName)
            case .gamesForMonth(let urlString):
                GamesForMonthView(gamesForMonthViewModel: di.createGameForMonthViewModel(), urlString: urlString)
            case .movesInGame(let moves, let playerOne, let playerTwo):
                MovesInGameView(movesInGameViewModel: di.createMovesInGameViewModel(), moves: moves, playerOne: playerOne, playerTwo: playerTwo)
            case .correspondenceView(let userName):
                CorrespondenceView(correspondenceViewModel: di.createCorrespondenceViewModel(), userName: userName)
            }
        }
    }
}
