//
//  ChessView.swift
//  MVVMArchitecture2AsyncAvait
//
//  Created by Александр Рахимов on 15.04.2023.
//

import SwiftUI

struct ChessView<Model>: View where Model: ChessViewModelProtocol {
    
    @EnvironmentObject private var navigationState: NavigationState
    @State private var isProgressVisible = false
    
    @StateObject var chessViewModel: Model
    private let userName: String
    
    init(chessViewModel: Model, userName: String) {
        _chessViewModel = StateObject(wrappedValue: chessViewModel)
        self.userName = userName
    }
    
    var body: some View {
        
        GeometryReader { geometry in
            
            let widthScreen = geometry.frame(in: .local).width
            let heightScreen = geometry.frame(in: .local).height
            
            ScrollView {
                VStack(alignment: .center) {
                    VStack {
                        asyncImageView
                            .position(x: widthScreen * 0.5, y: heightScreen * 0.25)
                            .shadow(color: Color("shadow"), radius: 10, x: 0, y: 0)
                        Text(chessViewModel.user?.username ?? "")
                            .font(.custom("Courier", size: 40))
                            .bold()
                            .padding(.bottom, 5)
                            .foregroundColor(.white)
                            .shadow(color: Color("shadow"), radius: 10, x: 0, y: 0)
                        HStack {
                            Image("online")
                                .resizable()
                                .frame(width: 50, height: 50)
                            Text("last online: \(chessViewModel.user?.lastOnline ?? "")")
                                .font(.custom("Courier", size: 20))
                        }
                        .foregroundColor(.white)
                        .shadow(color: Color("shadow"), radius: 5, x: 0, y: 0)
                        HStack {
                            Image("start")
                                .resizable()
                                .frame(width: 50, height: 50)
                            Text("joined: \(chessViewModel.user?.joined ?? "")")
                                .font(.custom("Courier", size: 20))
                        }
                        .foregroundColor(.white)
                        .shadow(color: Color("shadow"), radius: 5, x: 0, y: 0)
                        Spacer()
                    }
                    
                    .frame(height: heightScreen * 0.6)
                    .padding(.bottom, 50)
                    ZStack {
                        RatingsView(chessViewModel: chessViewModel)
                        if isProgressVisible {
                            ProgressView().tint(Color.white)
                                .offset(x: 0, y: 80)
                                .shadow(color: Color("shadow"), radius: 10, x: 0, y: 0)
                        }
                    }
                }
            }
            .navigationBarBackButtonHidden(true)
            .toolbar {
                // MARK: - change user
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Change user name") {
                        navigationState.dismiss()
                    }
                    .font(.custom("Courier", size: 20))
                    .foregroundColor(Color("text"))
                    .shadow(color: Color("shadow"), radius: 5, x: 0, y: 0)
                }
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    // MARK: - reload rating
                    Image(systemName: "questionmark.circle")
                        .foregroundColor(Color("text"))
                        .shadow(color: Color("shadow"), radius: 5, x: 0, y: 0)
                        .contextMenu {
                            contentMenuView
                        }
                        .padding(.trailing, 13)
                    // MARK: - download daily
                    Button {
                        navigationState.navigate(to: .correspondenceView(userName: userName))
                    } label: {
                        Image(systemName: "person.badge.clock")
                            .foregroundColor(Color("text"))
                            .shadow(color: Color("shadow"), radius: 5, x: 0, y: 0)
                    }

                    // MARK: - download archive
                    Button {
                        navigationState.navigate(to: .archive(userName: userName))
                    } label: {
                        Image(systemName: "externaldrive.badge.icloud")
                            .foregroundColor(Color("text"))
                            .shadow(color: Color("shadow"), radius: 5, x: 0, y: 0)
                    }
                }
            }
            .onAppear {
                fetchData(userName: userName)
            }
        }
        .background {
            Color("background")
        }
        .edgesIgnoringSafeArea(.all)
        .refreshable {
            isProgressVisible = true
            chessViewModel.rating?.removeAll()
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                fetchData(userName: userName)
            }
            print(userName)
        }
    }
    
    // MARK: - functions
    func fetchData(userName: String) {
        Task {
            do {
                try await chessViewModel.fetchData(userName: userName)
            }
            catch {
                print(Errors.errorGetUser)
            }
        }
    }
    
    // MARK: - asyncImageView
    var asyncImageView: some View {
        ZStack {
            AsyncImage(url: URL(string: chessViewModel.user?.avatar ?? "")) { result in
                switch result {
                case .empty:
                    ProgressView().tint(Color.white)
                        .shadow(color: Color("shadow"), radius: 10, x: 0, y: 0)
                case .success(let image):
                    image
                        .resizable()
                        .scaledToFit()
                        .frame(width: 150, height: 150)
                        .cornerRadius(30)
                case .failure(let error):
                    VStack {
                        Image(systemName: "questionmark")
                        Text(error.localizedDescription)
                            .font(.headline)
                    }
                @unknown default:
                    fatalError()
                }
            }
        }
    }
    
    var contentMenuView: some View {
        VStack {
            Text("Choose rating for widget")
            Button {
                chessViewModel.setTypeOfRating(type: RatingEnum.rapid.rawValue)
            } label: {
                HStack {
                    Image(RatingEnum.rapid.rawValue)
                        .padding(.trailing, 20)
                    Text(RatingEnum.rapid.rawValue)
                }
            }
            Button {
                chessViewModel.setTypeOfRating(type: RatingEnum.blitz.rawValue)
            } label: {
                HStack {
                    Image(RatingEnum.blitz.rawValue)
                        .padding(.trailing, 20)
                    Text(RatingEnum.blitz.rawValue)
                }
            }
            Button {
                chessViewModel.setTypeOfRating(type: RatingEnum.bullet.rawValue)
            } label: {
                HStack {
                    Image(RatingEnum.bullet.rawValue)
                        .padding(.trailing, 20)
                    Text(RatingEnum.bullet.rawValue)
                }
            }
            Button {
                chessViewModel.setTypeOfRating(type: RatingEnum.daily.rawValue)
            } label: {
                HStack {
                    Image(RatingEnum.daily.rawValue)
                        .padding(.trailing, 20)
                    Text(RatingEnum.daily.rawValue)
                }
            }
            Button {
                chessViewModel.setTypeOfRating(type: RatingEnum.tactic.rawValue)
            } label: {
                HStack {
                    Image(RatingEnum.tactic.rawValue)
                        .padding(.trailing, 20)
                    Text(RatingEnum.tactic.rawValue)
                }
            }
        }
    }
}

