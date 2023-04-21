//
//  GamesForMonthView.swift
//  MVVMArchitecture2AsyncAvait
//
//  Created by Александр Рахимов on 18.04.2023.
//

import SwiftUI

struct GamesForMonthView<Model>: View where Model: GamesForMonthViewModelProtocol {
    
    private let urlString: String
    @EnvironmentObject private var navigationState: NavigationState
    @StateObject var gamesForMonthViewModel: Model
    
    init(gamesForMonthViewModel: Model, urlString: String) {
        _gamesForMonthViewModel = StateObject(wrappedValue: gamesForMonthViewModel)
        self.urlString = urlString
    }
    
    
    var body: some View {
        ZStack {
            Color("background").ignoresSafeArea()
            List(gamesForMonthViewModel.games ?? []) { game in
                VStack {
                    Button {
                        navigationState.navigate(to: .movesInGame(moves: game.pgn ?? "", playerOne: game.whitePlayerName ?? "", playerTwo: game.blackPlayerName ?? ""))
                    } label: {
                        HStack {
                            Image("game")
                                .resizable()
                                .frame(width: 50, height: 50)
                                .shadow(color: Color("shadow"), radius: 10, x: 0, y: 0)
                            VStack(alignment: .leading) {
                                // MARK: - Type
                                Text(game.type ?? "")
                                    .font(.custom("Courier", size: 10))
                                    .foregroundColor(Color("background").opacity(0.75))
                                    .shadow(color: Color("shadow"), radius: 10, x: 0, y: 0)
                                // MARK: - names of players
                                HStack {
                                    Text(game.whitePlayerName ?? "")
                                        .foregroundColor(.white)
                                    
                                    Text("vs")
                                        .font(.custom("Courier", size: 25))
                                        .foregroundColor(Color("background").opacity(0.3))
                                    Text(game.blackPlayerName ?? "")
                                        .foregroundColor(.black)
                                    
                                }
                                .font(.custom("Courier", size: 15))
                                .shadow(color: Color("shadow"), radius: 10, x: 0, y: 0)
                                
                                // MARK: - rating
                                HStack {
                                    Text("\(game.whitePlayerRating ?? 0)")
                                        .foregroundColor(Color("background").opacity(0.75))
                                        .font(.custom("Courier", size: 10))
                                    Text("-")
                                        .foregroundColor(Color("background").opacity(0.75))
                                    Text("\(game.blackPlayerRating ?? 0)")
                                        .foregroundColor(Color("background").opacity(0.75))
                                        .font(.custom("Courier", size: 10))
                                }
                                // MARK: - result
                                HStack {
                                    Text(game.whitePlayerResult ?? "")
                                        .foregroundColor(.white)
                                    Text("-")
                                        .foregroundColor(Color("background").opacity(0.75))
                                    Text(game.blackPlayerResult ?? "")
                                        .foregroundColor(.black)
                                }
                                .font(.custom("Courier", size: 15))
                                .shadow(color: Color("shadow"), radius: 10, x: 0, y: 0)
                            }
                        }
                    }
                }
                .listRowBackground(Color("text"))
            }
            .listStyle(.plain)
            .navigationBarBackButtonHidden(true)
            .navigationTitle("Games")
            .navigationBarTitleDisplayMode(.large)
            .toolbarBackground(Color("background"), for: .navigationBar)
            .toolbar {
                // MARK: - back
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Back to archive") {
                        navigationState.dismiss()
                    }
                    .font(.custom("Courier", size: 20))
                    .foregroundColor(Color("text"))
                    .shadow(color: Color("shadow"), radius: 5, x: 0, y: 0)
                }
            }
            .onAppear {
                fetchData(urlString: urlString)
            }
            .edgesIgnoringSafeArea(.bottom)
        }
    }
    
    // MARK: - functions
    func fetchData(urlString: String) {
        Task {
            do {
                try await gamesForMonthViewModel.fetchGames(urlString: urlString)
            }
            catch {
                print(Errors.errorGetGames)
            }
        }
    }
}
