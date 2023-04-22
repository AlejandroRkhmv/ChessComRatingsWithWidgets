//
//  URLsCreatorProtocol.swift
//  MVVMArchitecture2AsyncAvait
//
//  Created by Александр Рахимов on 22.04.2023.
//

import Foundation

protocol URLsCreatorProtocol {
    func ratingURL(userName: String) -> URL?
    func userURL(userName: String) -> URL?
    func archiveURL(userName: String) -> URL?
    func gamesURL(urlString: String) -> URL?
    func correspondenceParty(userName: String) -> URL?
}
