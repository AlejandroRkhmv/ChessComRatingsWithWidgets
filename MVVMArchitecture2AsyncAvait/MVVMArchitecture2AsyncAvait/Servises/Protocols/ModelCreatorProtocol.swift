//
//  ModelCreatorProtocol.swift
//  MVVMArchitecture2AsyncAvait
//
//  Created by Александр Рахимов on 22.04.2023.
//

import Foundation

protocol ModelCreatorProtocol {
    func createUser(from userApi: UserAPI) -> User
    func createRapid(from ratingApi: RatingAPI) -> Rapid
    func createBlitz(from ratingApi: RatingAPI) -> Blitz
    func createTactic(from ratingApi: RatingAPI) -> Tactic
    func createBullet(from ratingApi: RatingAPI) -> Bullet
    func createDaily(from ratingApi: RatingAPI) -> Daily
    func archiveGames(from archiveApi: ArchiveAPI) -> Archive
    func createGame(from gameApi: GameApi) -> Game
    func createCorrespondenceParty(from correspondence: Correspondence) -> CorrespondenceParty
}
