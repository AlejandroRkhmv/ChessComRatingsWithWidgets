//
//  ApiModelCreatorFromData.swift
//  MVVMArchitecture2AsyncAvait
//
//  Created by Александр Рахимов on 16.04.2023.
//

import Foundation

class ApiModelCreatorFromData: ApiModelCreatorFromDataProtocol {
    private let decoder = JSONDecoder()
    
    func createUserApi(from data: Data) -> UserAPI? {
        do {
            let userApi = try decoder.decode(UserAPI.self, from: data)
            return userApi
        } catch {
            print(Errors.errorCreateUserAPI)
        }
        return nil
    }
    
    func createRatingApi(from data: Data) -> RatingAPI? {
        do {
            let userApi = try decoder.decode(RatingAPI.self, from: data)
            return userApi
        } catch {
            print(Errors.errorCreateRatingAPI)
        }
        return nil
    }
    
    func createArchiveApi(from data: Data) -> ArchiveAPI? {
        do {
            let archiveApi = try decoder.decode(ArchiveAPI.self, from: data)
            return archiveApi
        } catch {
            print(Errors.errorCreateArchiveAPI)
        }
        return nil
    }
    
    func createGamesApi(from data: Data) -> GamesAPI? {
        do {
            let gamesApi = try decoder.decode(GamesAPI.self, from: data)
            return gamesApi
        } catch {
            print(Errors.errorCreateGamesAPI)
        }
        return nil
    }
    
    func createCorrespondenceParty(from data: Data) -> CorrespondencePartyApi? {
        do {
            let correspondenceApi = try decoder.decode(CorrespondencePartyApi.self, from: data)
            return correspondenceApi
        } catch {
            print(Errors.errorCreateCorrespondenceAPI)
        }
        return nil
    }
}
