//
//  CorrespondenceView.swift
//  MVVMArchitecture2AsyncAvait
//
//  Created by Александр Рахимов on 20.04.2023.
//

import SwiftUI

struct CorrespondenceView<Model>: View where Model: CorrespondenceViewModelProtocol {
    
    @EnvironmentObject private var navigationState: NavigationState
    @StateObject var correspondenceViewModel: Model
    private let userName: String
    
    init(correspondenceViewModel: Model, userName: String) {
        _correspondenceViewModel = StateObject(wrappedValue: correspondenceViewModel)
        self.userName = userName
    }
    
    var body: some View {
        ZStack {
            Color("background").ignoresSafeArea()
            List(correspondenceViewModel.correspondenceParty ?? [] ) { correspondenceParty in
                Button {
                    correspondenceViewModel.selectCorrespondencePartyForWidget(party: correspondenceParty)
                    print("daily")
                } label: {
                    VStack(alignment: .leading) {
                        HStack {
                            Text(correspondenceViewModel.playerName(from: correspondenceViewModel.unwrapText(text: correspondenceParty.whitePlayer)))
                                .foregroundColor(.white)
                                .font(.custom("Courier", size: 20))
                                .shadow(color: Color("shadow"), radius: 10, x: 0, y: 0)
                            Text("vs")
                                .foregroundColor(Color("background"))
                                .font(.custom("Courier", size: 10))
                                .shadow(color: Color("shadow"), radius: 10, x: 0, y: 0)
                            Text(correspondenceViewModel.playerName(from: correspondenceViewModel.unwrapText(text: correspondenceParty.blackPlayer)))
                                .foregroundColor(.black)
                                .font(.custom("Courier", size: 20))
                                .shadow(color: Color("shadow"), radius: 10, x: 0, y: 0)
                        }
                        .padding(.bottom, 20)
                        Text(correspondenceViewModel.lastMove(from: correspondenceViewModel.createNeedsMovesString(from: correspondenceViewModel.unwrapText(text: correspondenceParty.pgn))))
                            .foregroundColor(Color("background").opacity(0.75))
                            .font(.custom("Courier", size: 30))
                            .shadow(color: Color("shadow"), radius: 10, x: 0, y: 0)
                    }
                }
                .listRowBackground(Color("text"))
            }
            .listStyle(.plain)
            .navigationBarBackButtonHidden(true)
            .navigationTitle("Correspondence")
            .navigationBarTitleDisplayMode(.large)
            .toolbarBackground(Color("background"), for: .navigationBar)
            .toolbar {
                // MARK: - back
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Back to profile") {
                        navigationState.dismiss()
                    }
                    .font(.custom("Courier", size: 20))
                    .foregroundColor(Color("text"))
                    .shadow(color: Color("shadow"), radius: 5, x: 0, y: 0)
                }
            }
            .onAppear {
                fetchData(userName: userName)
            }
        }
        .edgesIgnoringSafeArea(.bottom)
    }
    
    // MARK: - functions
    func fetchData(userName: String) {
        Task {
            do {
                try await correspondenceViewModel.fetchData(userName: userName)
            }
            catch {
                print(Errors.errorGetUser)
            }
        }
    }
}
