//
//  CorrespondenceParty.swift
//  MVVMArchitecture2AsyncAvait
//
//  Created by Александр Рахимов on 20.04.2023.
//

import Foundation

class CorrespondenceParty: Identifiable {
    let identifier: String?
    let pgn: String?
    let turn: String?
    let whitePlayer: String?
    let blackPlayer: String?
    
    init(correspondence: Correspondence) {
        self.identifier = correspondence.url
        self.pgn = correspondence.pgn
        self.turn = correspondence.turn
        self.whitePlayer = correspondence.white
        self.blackPlayer = correspondence.black
    }
}
