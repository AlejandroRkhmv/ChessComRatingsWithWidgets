//
//  GamesForMonthViewModel.swift
//  MVVMArchitecture2AsyncAvait
//
//  Created by Александр Рахимов on 19.04.2023.
//

import Foundation

protocol GamesForMonthViewModelProtocol: ObservableObject, AnyObject {
    var networcService: NetworkService? { get set }
    var games: [Game]? { get set }
    func fetchGames(urlString: String) async throws
}

class GamesForMonthViewModel: GamesForMonthViewModelProtocol {
    
    var networcService: NetworkService?
    @Published var games: [Game]?
    
    @MainActor
    func fetchGames(urlString: String) async throws {
        self.games = try await networcService?.fetchGames(urlString: urlString)
    }
}
