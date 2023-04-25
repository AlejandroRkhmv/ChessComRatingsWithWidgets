//
//  ModelCreatorProtocol.swift
//  MVVMArchitecture2AsyncAvait
//
//  Created by Александр Рахимов on 22.04.2023.
//

import Foundation

protocol ModelCreatorProtocol {
    func createUser(from userApi: UserAPI) -> User
    func createRatings(from ratingApi: RatingAPI) -> [RatingProtocol]
    func archiveGames(from archiveApi: ArchiveAPI) -> Archive
    func createGame(from gameApi: GameApi) -> Game
    func createCorrespondenceParty(from correspondence: Correspondence) -> CorrespondenceParty
}
