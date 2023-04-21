//
//  User.swift
//  MVVMArchitecture2AsyncAvait
//
//  Created by Александр Рахимов on 15.04.2023.
//

import Foundation

class User {
    let avatar: String
    let username: String
    let lastOnline: String
    let joined: String
    
    init(userApi: UserAPI) {
        self.avatar = userApi.avatar
        self.username = userApi.username
        self.lastOnline = DateCreator.dateString(from: userApi.lastOnline)
        self.joined = DateCreator.dateString(from: userApi.joined)
    }
}
