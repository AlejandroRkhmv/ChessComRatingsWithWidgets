//
//  ApiModelCreatorFromDataProtocol.swift
//  MVVMArchitecture2AsyncAvait
//
//  Created by Александр Рахимов on 22.04.2023.
//

import Foundation

protocol ApiModelCreatorFromDataProtocol {
    func createUserApi(from data: Data) -> UserAPI?
    func createRatingApi(from data: Data) -> RatingAPI?
    func createArchiveApi(from data: Data) -> ArchiveAPI?
    func createGamesApi(from data: Data) -> GamesAPI?
    func createCorrespondenceParty(from data: Data) -> CorrespondencePartyApi?
}
