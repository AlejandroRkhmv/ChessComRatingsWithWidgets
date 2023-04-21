//
//  ArchiveViewModel.swift
//  MVVMArchitecture2AsyncAvait
//
//  Created by Александр Рахимов on 18.04.2023.
//

import Foundation

protocol ArchiveViewModelProtocol: ObservableObject, AnyObject {
    var networcService: NetworkService? { get set }
    var archiveGames: [String]? { get set }
    func fetchArchive(userName: String) async throws
    func createArchiveDate(archiveMonth: String) -> String
}

class ArchiveViewModel: ArchiveViewModelProtocol {
    
    var networcService: NetworkService?
    @Published var archiveGames: [String]?
    
    @MainActor
    func fetchArchive(userName: String) async throws {
        self.archiveGames = try await networcService?.fetchAchiveData(userName: userName)
    }
    
    func createArchiveDate(archiveMonth: String) -> String {
        let date = archiveMonth.suffix(7)
        let dateComponents = date.components(separatedBy: "/")
        let archiveDate = "Games for " + dateComponents[1] + "." + dateComponents[0]
        return archiveDate
    }
}
