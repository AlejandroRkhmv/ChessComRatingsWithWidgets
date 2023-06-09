//
//  NetworkService.swift
//  MVVMArchitecture2AsyncAvait
//
//  Created by Александр Рахимов on 15.04.2023.
//

import Foundation

class NetworkService: NetworkServiceProtocol {
    var apiModelCreator: ApiModelCreatorFromDataProtocol?
    var modelCreator: ModelCreatorProtocol?
    var urlCreator: URLsCreatorProtocol?
    var session = URLSession.init(configuration: .default)
    
    // MARK: - user
    func fetchUserData(userName: String) async throws -> User? {
        guard let url = urlCreator?.userURL(userName: userName) else {
            throw Errors.badUrl
        }
        
        let response = try await session.data(from: url)
        
        guard let userAPI = apiModelCreator?.createUserApi(from: response.0) else { return nil }
            let user = modelCreator?.createUser(from: userAPI)
            return user
    }
    
    // MARK: - rating
    func fetcRatingData(userName: String) async throws -> [RatingProtocol]? {
        guard let url = urlCreator?.ratingURL(userName: userName) else {
            throw Errors.badUrl
        }
        
        let response = try await session.data(from: url)
        
        guard let ratingAPI = apiModelCreator?.createRatingApi(from: response.0) else { return nil }
        guard let ratings = modelCreator?.createRatings(from: ratingAPI) else { return nil }
        return ratings
    }
    
    // MARK: - archive
    func fetchAchiveData(userName: String) async throws -> [String]? {
        var archive: [String]?
        guard let url = urlCreator?.archiveURL(userName: userName) else {
            throw Errors.badUrl
        }
        
        let response = try await session.data(from: url)
        guard let archiveAPI = apiModelCreator?.createArchiveApi(from: response.0) else { return nil }
        archive = modelCreator?.archiveGames(from: archiveAPI).archiveGames
        return archive?.reversed()
    }
    
    // MARK: - games
    func fetchGames(urlString: String) async throws -> [Game]? {
        var games = [Game]()
        guard let url = urlCreator?.gamesURL(urlString: urlString) else {
            throw Errors.badUrl
        }
        
        let response = try await session.data(from: url)
        guard let gamesApi = apiModelCreator?.createGamesApi(from: response.0) else { return nil }
        for gameApi in gamesApi.games {
            guard let game = modelCreator?.createGame(from: gameApi) else { return nil }
            games.append(game)
        }
        return games
    }
    
    // MARK: - daily correspondence
    func fetchCorrespondenceParties(userName: String) async throws -> [CorrespondenceParty]? {
        var correspondenceParties = [CorrespondenceParty]()
        guard let url = urlCreator?.correspondenceParty(userName: userName) else {
            throw Errors.badUrl
        }
        
        let response = try await session.data(from: url)
        guard let correspondenceApi = apiModelCreator?.createCorrespondenceParty(from: response.0) else { return nil }
        for party in correspondenceApi.games {
            guard let party = modelCreator?.createCorrespondenceParty(from: party) else { return nil }
            correspondenceParties.append(party)
        }
        return correspondenceParties
    }
}




