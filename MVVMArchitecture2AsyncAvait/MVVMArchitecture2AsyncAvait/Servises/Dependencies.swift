//
//  Dependencies.swift
//  MVVMArchitecture2AsyncAvait
//
//  Created by Александр Рахимов on 21.04.2023.
//

import Foundation
import Swinject

class Dependencies {
    
    // MARK: - chessViewModel
    let container: Container = {
        let container = Container()
        
        // MARK: - create needs services
        container.register(ApiModelCreatorFromDataProtocol.self) { _ in
            ApiModelCreatorFromData()
        }
        container.register(ModelCreatorProtocol.self) { _ in
            ModelCreator()
        }
        container.register(URLsCreatorProtocol.self) { _ in
            URLsCreator()
        }
        
        // MARK: - create network service
        container.register(NetworkServiceProtocol.self) { register in
            let networkService = NetworkService()
            networkService.apiModelCreator = (register.resolve(ApiModelCreatorFromDataProtocol.self) as! ApiModelCreatorFromData)
            networkService.modelCreator = (register.resolve(ModelCreatorProtocol.self) as! ModelCreator)
            networkService.urlCreator = (register.resolve(URLsCreatorProtocol.self) as! URLsCreator)
            return networkService
        }
        
        // MARK: - create chessViewModel
        container.register((any ChessViewModelProtocol).self) { register in
            let chessViewModel = ChessViewModel()
            chessViewModel.networkService = (register.resolve(NetworkServiceProtocol.self) as! NetworkService)
            return chessViewModel
        }
        
        // MARK: - create correspondenceViewModel
        container.register((any CorrespondenceViewModelProtocol).self) { register in
            let correspondenceViewModel = CorrespondenceViewModel()
            correspondenceViewModel.networcService = (register.resolve(NetworkServiceProtocol.self) as! NetworkService)
            return correspondenceViewModel
        }
        
        // MARK: - create archiveViewModel
        container.register((any ArchiveViewModelProtocol).self) { register in
            let archiveViewModel = ArchiveViewModel()
            archiveViewModel.networcService = (register.resolve(NetworkServiceProtocol.self) as! NetworkService)
            return archiveViewModel
        }
        
        // MARK: - create gameForMonthViewModel
        container.register((any GamesForMonthViewModelProtocol).self) { register in
            let gameForMonthViewModel = GamesForMonthViewModel()
            gameForMonthViewModel.networcService = (register.resolve(NetworkServiceProtocol.self) as! NetworkService)
            return gameForMonthViewModel
        }
        
        container.register((any MovesInGameViewModelProtocol).self) { register in
            let movesInGameViewModel = MovesInGameViewModel()
            return movesInGameViewModel
        }
                           
        return container
    }()
    
    func createChessViewModel() -> ChessViewModel {
        let chessViewModel = container.resolve((any ChessViewModelProtocol).self)! as! ChessViewModel
        return chessViewModel
    }
    
    func createCorrespondenceViewModel() -> CorrespondenceViewModel {
        let correspondenceViewModel = container.resolve((any CorrespondenceViewModelProtocol).self)! as! CorrespondenceViewModel
        return correspondenceViewModel
    }
    
    func createArchiveViewModel() -> ArchiveViewModel {
        let archiveViewModel = container.resolve((any ArchiveViewModelProtocol).self)! as! ArchiveViewModel
        return archiveViewModel
    }
    
    func createGameForMonthViewModel() -> GamesForMonthViewModel {
        let gameForMonthViewModel = container.resolve((any GamesForMonthViewModelProtocol).self)! as! GamesForMonthViewModel
        return gameForMonthViewModel
    }
    
    func createMovesInGameViewModel() -> MovesInGameViewModel {
        let movesInGameViewModel = container.resolve((any MovesInGameViewModelProtocol).self)! as! MovesInGameViewModel
        return movesInGameViewModel
    }
}
