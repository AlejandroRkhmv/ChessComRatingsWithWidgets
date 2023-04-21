//
//  UserModel.swift
//  MVVMArchitecture2AsyncAvait
//
//  Created by Александр Рахимов on 15.04.2023.
//

import Foundation

// MARK: - User
struct UserAPI: Codable {
    let avatar: String
    let playerID: Int
    let id, url: String
    let username: String
    let followers: Int
    let country: String
    let lastOnline, joined: Int
    let status: String
    let isStreamer, verified: Bool
    let league: String

    enum CodingKeys: String, CodingKey {
        case avatar
        case playerID = "player_id"
        case id = "@id"
        case url, username, followers, country
        case lastOnline = "last_online"
        case joined, status
        case isStreamer = "is_streamer"
        case verified, league
    }
}
