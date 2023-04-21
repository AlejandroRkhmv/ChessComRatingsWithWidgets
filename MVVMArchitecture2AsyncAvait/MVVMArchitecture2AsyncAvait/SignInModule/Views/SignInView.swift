//
//  SignInView.swift
//  MVVMArchitecture2AsyncAvait
//
//  Created by Александр Рахимов on 15.04.2023.
//

import SwiftUI

struct SignInView: View {
    
    @EnvironmentObject private var navigationState: NavigationState
    @State private var userName = "lxndrrkhmv"
    @State private var isAlertShow = false
    
    var body: some View {
        ZStack {
            VStack {
                Spacer()
                // MARK: - text field
                TextField("Enter your user name", text: $userName).foregroundColor(Color("text"))
                    .padding(20)
                    .overlay {
                        RoundedRectangle(cornerRadius: 15)
                            .strokeBorder(Color.black, style: .init(lineWidth: 2))
                    }
                    .padding()
                
                // MARK: - button to go to the next screen
                Button {
                    if userName != "" {
                        navigationState.navigate(to: .chessView(userName: userName))
                        userName = ""
                    } else {
                        isAlertShow = true
                    }
                } label: {
                    HStack {
                        Image("figures")
                            .resizable()
                            .frame(width: 50, height: 50)
                        Text("Get data from Chess.com API")
                            .font(.custom("Courier", size: 15))
                            .foregroundColor(Color("text"))
                            .shadow(color: Color("shadow"), radius: 5, x: 0, y: 0)
                    }
                }
                .foregroundColor(.black)
                Spacer()
            }
            .background {
                Color("background")
            }
        }
        .alertModifier(isAlertShow: $isAlertShow)
        .edgesIgnoringSafeArea(.all)
    }
}

// MARK: - Alert Modifier
struct AlertView: ViewModifier {
    @Binding var isAlertShow: Bool
    func body(content: Content) -> some View {
        content
            .alert("User name can not be empty...", isPresented: $isAlertShow) {
                Button {
                    isAlertShow = false
                } label: {
                    Text("OK")
                        .font(.custom("Courier", size: 10))
                }
                
            } message: {
                Text("Please press \"OK\" and enter user name")
                    .font(.custom("Courier", size: 10))
            }
    }
}

// MARK: - extension for view with Alert Modifier
extension View {
    func alertModifier(isAlertShow: Binding<Bool>) -> some View {
        self.modifier(AlertView(isAlertShow: isAlertShow))
    }
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView()
    }
}
