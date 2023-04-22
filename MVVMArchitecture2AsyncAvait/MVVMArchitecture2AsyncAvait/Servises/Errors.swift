//
//  Errors.swift
//  MVVMArchitecture2AsyncAvait
//
//  Created by Александр Рахимов on 16.04.2023.
//

import Foundation

enum Errors: Error {
    case badUrl
    case errorCreateUserAPI
    case errorCreateRatingAPI
    case errorCreateArchiveAPI
    case errorCreateGamesAPI
    case errorCreateCorrespondenceAPI
    case errorGetUser
    case errorGetRating
    case errorGetArchive
    case errorGetGames
    case errorGetCorrespondenceParty
    case errorDecodeForWidget
    case errorEncodeForWidget
    case errorMakeUserForWidget
}
