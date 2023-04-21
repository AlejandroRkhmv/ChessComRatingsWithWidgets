//
//  DecoderEncoderSupport.swift
//  MVVMArchitecture2AsyncAvait
//
//  Created by Александр Рахимов on 17.04.2023.
//

import Foundation

class DecoderEncoderSupport {
    
    static func encodeUser(from user: UserForWidget) -> Data {
        let encoder = JSONEncoder()
        do {
            let data = try encoder.encode(user)
            return data
        }
        catch {
            print(error.localizedDescription)
        }
        return Data()
    }
    
    static func decodeUser(from data: Data) -> UserForWidget {
        let decoder = JSONDecoder()
        do {
            let user = try decoder.decode(UserForWidget.self, from: data)
            return user
        }
        catch {
            print(error.localizedDescription)
        }
        return UserForWidget()
    }
    
    static func encodeParty(from party: PartyForWidget) -> Data {
        let encoder = JSONEncoder()
        do {
            let data = try encoder.encode(party)
            return data
        }
        catch {
            print(error.localizedDescription)
        }
        return Data()
    }
    
    static func decodeParty(from data: Data) -> PartyForWidget {
        let decoder = JSONDecoder()
        do {
            let party = try decoder.decode(PartyForWidget.self, from: data)
            return party
        }
        catch {
            print(error.localizedDescription)
        }
        return PartyForWidget()
    }
}
