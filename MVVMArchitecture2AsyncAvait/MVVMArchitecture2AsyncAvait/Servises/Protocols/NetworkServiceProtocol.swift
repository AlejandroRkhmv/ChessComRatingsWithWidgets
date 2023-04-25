//
//  NetworkServiceProtocol.swift
//  MVVMArchitecture2AsyncAvait
//
//  Created by Александр Рахимов on 22.04.2023.
//

import Foundation

protocol NetworkServiceProtocol {
    var apiModelCreator: ApiModelCreatorFromDataProtocol? { get set }
    var modelCreator: ModelCreatorProtocol? { get set }
    var urlCreator: URLsCreatorProtocol? { get set }
    var session: URLSession { get set }
    
    func fetchUserData(userName: String) async throws -> User?
    func fetcRatingData(userName: String) async throws -> [RatingProtocol]?
    func fetchAchiveData(userName: String) async throws -> [String]?
    func fetchGames(urlString: String) async throws -> [Game]?
    func fetchCorrespondenceParties(userName: String) async throws -> [CorrespondenceParty]?
}
