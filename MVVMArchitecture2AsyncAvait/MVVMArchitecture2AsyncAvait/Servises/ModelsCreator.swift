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
    
    func createRatings(from ratingApi: RatingAPI) -> [RatingProtocol] {
        var ratings: [RatingProtocol] = []
        let rapid = Rapid(ratingApi: ratingApi)
        let blitz = Blitz(ratingApi: ratingApi)
        let tactic = Tactic(ratingApi: ratingApi)
        let bullet = Bullet(ratingApi: ratingApi)
        let daily = Daily(ratingApi: ratingApi)
        ratings.append(rapid)
        ratings.append(blitz)
        ratings.append(tactic)
        ratings.append(daily)
        ratings.append(bullet)
        return ratings
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
