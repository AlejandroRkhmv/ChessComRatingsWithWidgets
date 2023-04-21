//
//  ArchiveView.swift
//  MVVMArchitecture2AsyncAvait
//
//  Created by Александр Рахимов on 18.04.2023.
//

import SwiftUI

struct ArchiveView<Model>: View where Model: ArchiveViewModelProtocol {
    @EnvironmentObject private var navigationState: NavigationState
    @StateObject var archiveViewModel: Model
    @State private var isLoading = false
    private let userName: String
    
    init(archiveViewModel: Model, userName: String) {
        _archiveViewModel = StateObject(wrappedValue: archiveViewModel)
        self.userName = userName
    }
    
    var body: some View {
        ZStack {
            Color("background").ignoresSafeArea()
            List(archiveViewModel.archiveGames ?? [], id: \.self) { archive in
                HStack {
                    Image("month")
                        .resizable()
                        .frame(width: 50, height: 50)
                        .shadow(color: Color("shadow"), radius: 10, x: 0, y: 0)
                    Button {
                        navigationState.navigate(to: .gamesForMonth(urlString: archive))
                    } label: {
                        Text(archiveViewModel.createArchiveDate(archiveMonth: archive))
                            .font(.custom("Courier", size: 20))
                            .foregroundColor(Color("background").opacity(0.75))
                            .shadow(color: Color("shadow"), radius: 10, x: 0, y: 0)
                    }
                }
                .listRowBackground(Color("text"))
            }
            .listStyle(.plain)
            .navigationBarBackButtonHidden(true)
            .navigationTitle("Archive of games")
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
            .edgesIgnoringSafeArea(.bottom)
        }
    }
    
    // MARK: - functions
    func fetchData(userName: String) {
        Task {
            do {
                try await archiveViewModel.fetchArchive(userName: userName)
            }
            catch {
                print(Errors.errorGetArchive)
            }
        }
    }
}



