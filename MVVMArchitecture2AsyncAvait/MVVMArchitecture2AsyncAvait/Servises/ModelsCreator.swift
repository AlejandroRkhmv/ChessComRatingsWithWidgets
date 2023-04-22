//
//  ModelsCreator.swift
//  MVVMArchitecture2AsyncAvait
//
//  Created by Александр Рахимов on 15.04.2023.
//

import Foundation

class ModelCreator: ModelCreatorProtocol {
    func createUser(from userApi: UserAPI) -> User {
        let user = User(userApi: userApi)
        return user
    }
    
    func createRapid(from ratingApi: RatingAPI) -> Rapid {
        let rapid = Rapid(ratingApi: ratingApi)
        return rapid
    }
    
    func createBlitz(from ratingApi: RatingAPI) -> Blitz {
        let blitz = Blitz(ratingApi: ratingApi)
        return blitz
    }
    
    func createTactic(from ratingApi: RatingAPI) -> Tactic {
        let tactic = Tactic(ratingApi: ratingApi)
        return tactic
    }
    
    func createBullet(from ratingApi: RatingAPI) -> Bullet {
        let bullet = Bullet(ratingApi: ratingApi)
        return bullet
    }
    
    func createDaily(from ratingApi: RatingAPI) -> Daily {
        let daily = Daily(ratingApi: ratingApi)
        return daily
    }
    
    func archiveGames(from archiveApi: ArchiveAPI) -> Archive {
        let archive = Archive(archiveApi: archiveApi)
        return archive
    }
    
    func createGame(from gameApi: GameApi) -> Game {
        let game = Game(gamesApi: gameApi)
        return game
    }
    
    func createCorrespondenceParty(from correspondence: Correspondence) -> CorrespondenceParty {
        let party = CorrespondenceParty(correspondence: correspondence)
        return party
    }
}
