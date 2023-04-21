//
//  MovesInGameView.swift
//  MVVMArchitecture2AsyncAvait
//
//  Created by Александр Рахимов on 19.04.2023.
//

import SwiftUI

struct MovesInGameView<Model>: View where Model: MovesInGameViewModelProtocol {
    @EnvironmentObject private var navigationState: NavigationState
    @StateObject var movesInGameViewModel: Model
    
    private let moves: String
    private let playerOne: String
    private let playerTwo: String
    
    init(movesInGameViewModel: Model, moves: String, playerOne: String, playerTwo: String) {
        _movesInGameViewModel = StateObject(wrappedValue: movesInGameViewModel)
        self.moves = moves
        self.playerOne = playerOne
        self.playerTwo = playerTwo
    }
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            Text(movesInGameViewModel.createNeedsMovesString(from: moves))
                .foregroundColor(Color("text"))
                .font(.custom("Courier", size: 20))
                .shadow(color: Color("shadow"), radius: 10, x: 0, y: 0)
                .padding(.top, 110)
        }
        .padding()
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button("Back to games") {
                    navigationState.dismiss()
                }
                .font(.custom("Courier", size: 20))
                .foregroundColor(Color("text"))
                .shadow(color: Color("shadow"), radius: 5, x: 0, y: 0)
            }
            ToolbarItem(placement: .navigation) {
                HStack {
                    Text(playerOne)
                        .font(.custom("Courier", size: 10))
                        .foregroundColor(.white)
                    Text(playerTwo)
                        .font(.custom("Courier", size: 10))
                        .foregroundColor(.black)
                }
                .shadow(color: Color("shadow"), radius: 10, x: 0, y: 0)
            }
        }
        .toolbarBackground(Color("background"), for: .navigationBar)
        .background {
            Color("background")
        }
        .edgesIgnoringSafeArea(.all)
    }
}
