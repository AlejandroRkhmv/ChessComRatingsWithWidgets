//
//  CorrespondenceViewModel.swift
//  MVVMArchitecture2AsyncAvait
//
//  Created by Александр Рахимов on 20.04.2023.
//

import SwiftUI
import Foundation
import WidgetKit

protocol CorrespondenceViewModelProtocol: ObservableObject, AnyObject {
    
    var networcService: NetworkServiceProtocol? { get set }
    var correspondenceParty: [CorrespondenceParty]? { get set }
    func fetchData(userName: String) async throws 
    func selectCorrespondencePartyForWidget(party: CorrespondenceParty)
    func setIdentifierOfParty(urlString: String)
    func unwrapText(text: String?) -> String
    func playerName(from urlString: String) -> String
    func createNeedsMovesString(from pgn: String) -> String
    func lastMove(from allMoves: String) -> String
}

class CorrespondenceViewModel: CorrespondenceViewModelProtocol {
    
    @AppStorage("dailyData", store: UserDefaults(suiteName: "group.com.AlejandroRkhmv.MVVMArchitecture2AsyncAvait.ChessRatingWidget")!) var dailyData = Data()
    @AppStorage("urlOfDailyParty", store: UserDefaults(suiteName: "group.com.AlejandroRkhmv.MVVMArchitecture2AsyncAvait.ChessRatingWidget")!) var urlIdentifier = String()
    var networcService: NetworkServiceProtocol?
    @Published var correspondenceParty: [CorrespondenceParty]?
    
    @MainActor
    func fetchData(userName: String) async throws {
        self.correspondenceParty = try await networcService?.fetchCorrespondenceParties(userName: userName)
    }
    
    // MARK: - UPLOAD Party For widget
    func uploadParty(userName: String) {
        Task {
            do {
                try await fetchData(userName: userName)
                
            }
            catch {
                print(Errors.errorGetUser)
            }
        }
        guard let party = correspondenceParty?.first(where: {$0.identifier == urlIdentifier }) else { return }
        selectCorrespondencePartyForWidget(party: party)
    }
    
    func selectCorrespondencePartyForWidget(party: CorrespondenceParty) {
        let white = playerName(from: unwrapText(text: party.whitePlayer))
        let black = playerName(from: unwrapText(text: party.blackPlayer))
        let moves = lastMove(from: createNeedsMovesString(from: unwrapText(text: party.pgn)))
        let type = unwrapText(text: party.turn)
        
        // MARK: - create party for widget
        let partyForWidjet = PartyForWidget(white: white, black: black, moves: moves, typeOfParty: type)
        let dailyData = DecoderEncoderSupport.encodeParty(from: partyForWidjet)
        self.dailyData = dailyData
        // MARK: - reload widget after send type of rating
        WidgetCenter.shared.reloadAllTimelines()
    }
    
    func setIdentifierOfParty(urlString: String) {
        self.urlIdentifier = urlString
    }
    
    // MARK: - unwrapeText
    func unwrapText(text: String?) -> String {
        guard let unwrText = text else { return ""}
        return unwrText
    }
    
    // MARK: - createPlayerFromURL
    func playerName(from urlString: String) -> String {
        let component = urlString.components(separatedBy: "player/")
        let userName = component[1]
        return userName
    }
    
    // MARK: - moves
    func createNeedsMovesString(from pgn: String) -> String {
        let components = pgn.components(separatedBy: "\n\n")
        let moves = components[1]
        
        do {
            let regex = try NSRegularExpression(pattern: "(\\{\\[%clk\\s[0-9]?\\:?[0-9]{1,}\\:[0-9]{2}\\:[0-9]{2}\\.?[0-9]?\\]\\})")
            let range = NSMakeRange(0, moves.count)
            let modString = regex.stringByReplacingMatches(in: moves, range: range, withTemplate: "")
            return modString
        } catch let error {
            print("invalid regex: \(error.localizedDescription)")
            return ""
        }
    }
    
    // MARK: - oly last move
    func lastMove(from allMoves: String) -> String {
        do {
            let regex = try NSRegularExpression(pattern: "[1-9][0-9]{0,}?\\.\\s.{2,6}\\s([1-9][0-9]{0,}?\\...\\s.{2,6}\\s)?\\s[*]")
            let range = NSMakeRange(0, allMoves.count)
            let results = regex.matches(in: allMoves, range: range)
            
            let allMatches =  results.map {
                String(allMoves[Range($0.range, in: allMoves)!])
            }
            var lastMove = allMatches[0]
            lastMove.removeLast()
            return lastMove
        } catch let error {
            print("invalid regex: \(error.localizedDescription)")
            return ""
        }
    }
}
