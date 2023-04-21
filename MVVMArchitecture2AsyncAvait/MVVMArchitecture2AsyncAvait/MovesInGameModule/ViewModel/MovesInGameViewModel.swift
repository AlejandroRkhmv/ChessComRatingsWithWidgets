//
//  MovesInGameViewModel.swift
//  MVVMArchitecture2AsyncAvait
//
//  Created by Александр Рахимов on 21.04.2023.
//

import Foundation

protocol MovesInGameViewModelProtocol: ObservableObject, AnyObject {
    func createNeedsMovesString(from pgn: String) -> String
}

class MovesInGameViewModel: MovesInGameViewModelProtocol {
    
    // MARK: - functions
    func createNeedsMovesString(from pgn: String) -> String {
        let components = pgn.components(separatedBy: "\n\n")
        let moves = components[1]
        
        do {
            let regex = try NSRegularExpression(pattern: "(\\{\\[%clk\\s[0-9]?\\:?[0-9]{1,}\\:[0-9]{2}\\:[0-9]{2}\\.?[0-9]?\\]\\})")
            let range = NSMakeRange(0, moves.count)
            let modString = regex.stringByReplacingMatches(in: moves, range: range, withTemplate: "")
            return modString
        } catch let error {
            print("invalid regex: \(error.localizedDescription)")
            return ""
        }
    }
}
