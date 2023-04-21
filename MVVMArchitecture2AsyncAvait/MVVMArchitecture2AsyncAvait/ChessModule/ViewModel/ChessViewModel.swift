//
//  ChessViewModel.swift
//  MVVMArchitecture2AsyncAvait
//
//  Created by Александр Рахимов on 15.04.2023.
//

import SwiftUI
import Foundation

protocol ChessViewModelProtocol: ObservableObject, AnyObject {
    var user: User? { get set }
    var rating: [Rating]? { get set }
    var networcService: NetworkServiceProtocol? { get set }
    func fetchData(userName: String) async throws
    func setTypeOfRating(type: String)
}

class ChessViewModel: ChessViewModelProtocol {
    
    @AppStorage("user", store: UserDefaults.group) var userForWidget = Data()
    @AppStorage("typeOfRating", store: UserDefaults.group) var typeOfRating = String()
    
    var networcService: NetworkServiceProtocol?
    
    @Published var user: User?
    @Published var rating: [Rating]?
    
    @MainActor
    func fetchData(userName: String) async throws {
        self.user = try await networcService?.fetchUserData(userName: userName)
        self.rating = try await networcService?.fetcRatingData(userName: userName)
        setterUserForWidget(user: self.user, rating: self.rating)
    }
    
    func setTypeOfRating(type: String) {
        self.typeOfRating = type
        print(self.typeOfRating)
    }
    
    // MARK: - set user to userFor widget
    fileprivate func setterUserForWidget(user: User?, rating: [Rating]?) {
        guard let user = user, let rating = rating else { return }
        self.userForWidget = createUserForWidget(user: user, rating: rating)
    }
    
    // MARK: - create user for widget
    fileprivate func createUserForWidget(user: User, rating: [Rating]) -> Data {
        let userForWidget = UserForWidget(name: user.username, rapid: rating[0].rating, blitz: rating[1].rating, tactic: rating[2].rating, bullet: rating[3].rating, daily: rating[4].rating)
        let data = DecoderEncoderSupport.encodeUser(from: userForWidget)
        return data
    }
}

extension UserDefaults {
  static let group = UserDefaults(suiteName: "group.com.AlejandroRkhmv.MVVMArchitecture2AsyncAvait.ChessRatingWidget")!
}
