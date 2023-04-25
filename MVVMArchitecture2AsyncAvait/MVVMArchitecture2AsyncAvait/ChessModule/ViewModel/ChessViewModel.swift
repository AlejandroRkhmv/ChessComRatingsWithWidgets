//
//  ChessViewModel.swift
//  MVVMArchitecture2AsyncAvait
//
//  Created by Александр Рахимов on 15.04.2023.
//

import SwiftUI
import Foundation
import WidgetKit

protocol ChessViewModelProtocol: ObservableObject, AnyObject {
    var user: User? { get set }
    var rating: [RatingProtocol]? { get set }
    var networkService: NetworkServiceProtocol? { get set }
    func fetchData(userName: String) async throws
    func setTypeOfRating(type: String)
}

class ChessViewModel: ChessViewModelProtocol {
    
    @AppStorage("user", store: UserDefaults(suiteName: "group.com.AlejandroRkhmv.MVVMArchitecture2AsyncAvait.ChessRatingWidget")) var userForWidget = Data()
    @AppStorage("typeOfRating", store: UserDefaults(suiteName: "group.com.AlejandroRkhmv.MVVMArchitecture2AsyncAvait.ChessRatingWidget")) var typeOfRating = String()
    
    var networkService: NetworkServiceProtocol?
    
    @Published var user: User?
    @Published var rating: [RatingProtocol]?
    
    @MainActor
    func fetchData(userName: String) async throws {
        print("fetch rating")
        self.user = try await networkService?.fetchUserData(userName: userName)
        self.rating = try await networkService?.fetcRatingData(userName: userName)
        setterUserForWidget(user: self.user, rating: self.rating)
    }
    
    func setTypeOfRating(type: String) {
        self.typeOfRating = type
        print(self.typeOfRating)
        // MARK: - reload widget after send type of rating
        WidgetCenter.shared.reloadAllTimelines()
    }
    
    // MARK: - set user to userFor widget
    fileprivate func setterUserForWidget(user: User?, rating: [RatingProtocol]?) {
        guard let user = user, let rating = rating else { return }
        self.userForWidget = createUserForWidget(user: user, rating: rating)
        // MARK: - reload widget after send type of rating
        WidgetCenter.shared.reloadAllTimelines()
    }
    
    // MARK: - create user for widget
    fileprivate func createUserForWidget(user: User, rating: [RatingProtocol]) -> Data {
        let userForWidget = UserForWidget(name: user.username, rapid: rating[0].rating, blitz: rating[1].rating, tactic: rating[2].rating, bullet: rating[3].rating, daily: rating[4].rating)
        let data = DecoderEncoderSupport.encodeUser(from: userForWidget)
        return data
    }
}
