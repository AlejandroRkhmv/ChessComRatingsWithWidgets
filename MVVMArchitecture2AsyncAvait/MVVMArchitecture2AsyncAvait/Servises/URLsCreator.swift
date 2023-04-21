//
//  File.swift
//  MVVMArchitecture2AsyncAvait
//
//  Created by Александр Рахимов on 15.04.2023.
//

import Foundation

protocol URLsCreatorProtocol {
    func ratingURL(userName: String) -> URL?
    func userURL(userName: String) -> URL?
    func archiveURL(userName: String) -> URL?
    func gamesURL(urlString: String) -> URL?
    func correspondenceParty(userName: String) -> URL?
}

class URLsCreator: URLsCreatorProtocol {
    
    func ratingURL(userName: String) -> URL? {
        let urlString = "https://api.chess.com/pub/player/\(userName)/stats"
        let url = URL(string: urlString)
        return url
    }
    
    func userURL(userName: String) -> URL? {
        let urlString = "https://api.chess.com/pub/player/\(userName)"
        let url = URL(string: urlString)
        return url
    }
    
    func archiveURL(userName: String) -> URL? {
        let urlString = "https://api.chess.com/pub/player/\(userName)/games/archives"
        let url = URL(string: urlString)
        return url
    }
    
    func gamesURL(urlString: String) -> URL? {
        let url = URL(string: urlString)
        return url
    }
    
    func correspondenceParty(userName: String) -> URL? {
        let urlString = "https://api.chess.com/pub/player/\(userName)/games"
        let url = URL(string: urlString)
        return url
    }
}
