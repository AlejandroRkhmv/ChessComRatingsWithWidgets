//
//  RatingsView.swift
//  MVVMArchitecture2AsyncAvait
//
//  Created by Александр Рахимов on 16.04.2023.
//

import SwiftUI

struct RatingsView<Model>: View where Model: ChessViewModelProtocol {
    
    @StateObject var chessViewModel: Model
    @State private var snappedItem = 0.0
    @State private var draggingItem = 0.0
    
    init(chessViewModel: Model) {
        _chessViewModel = StateObject(wrappedValue: chessViewModel)
    }
    
    var body: some View {
        
        ZStack {
            if chessViewModel.rating != nil {
                ForEach(Array(chessViewModel.rating!.enumerated()), id: \.offset) { offset, rating in
                    
                    ZStack {
                        RoundedRectangle(cornerRadius: 18)
                            .fill(Color("elements"))
                        
                        VStack {
                            HStack {
                                Text(rating.title ?? "")
                                    .shadow(color: Color("shadow"), radius: 10, x: 0, y: 0)
                                    .bold()
                                    .font(.custom("Courier", size: 25))
                                    .padding()
                                Image(rating.logo ?? "")
                                    .resizable()
                                    .frame(width: 50, height: 50)
                                    .shadow(color: Color("shadow"), radius: 5, x: 0, y: 0)
                            }
                            Text("\(Int(rating.rating ?? 0))")
                                .font(.custom("Courier", size: 20))
                                .bold()
                                .padding(.bottom, 5)
                                .shadow(color: Color("shadow"), radius: 5, x: 0, y: 0)
                            Text(rating.ratingDate ?? "")
                                .font(.custom("Courier", size: 15))
                                .shadow(color: Color("shadow"), radius: 5, x: 0, y: 0)
                        }
                    }
                    .frame(width: 200, height: 200)
                    .scaleEffect(1.0 - abs(distance(offset)) * 0.2 )
                    .opacity(1.0 - abs(distance(offset)) * 0.3 )
                    .offset(x: myXOffset(offset), y: 0)
                    .zIndex(1.0 - abs(distance(offset)) * 0.1)
                }
            } else {
                ProgressView().tint(Color.white)
                    .shadow(color: Color("shadow"), radius: 10, x: 0, y: 0)
                    .offset(x: 0, y: 80)
            }
        }
        .gesture (
            DragGesture()
                .onChanged { value in
                    draggingItem = snappedItem + value.translation.width / 100
                }
                .onEnded { value in
                    withAnimation(.linear(duration: 3)) {
                        draggingItem = snappedItem + value.predictedEndTranslation.width / 100
                        draggingItem = round(draggingItem).remainder(dividingBy: Double((chessViewModel.rating?.count)!))
                        snappedItem = draggingItem
                    }
                }
        )
    }
    
    func distance(_ item: Int) -> Double {
        return (draggingItem - Double(item)).remainder(dividingBy: Double((chessViewModel.rating?.count)!))
    }
    
    func myXOffset(_ item: Int) -> Double {
        let angle = Double.pi * 2 / Double((chessViewModel.rating?.count)!) * distance(item)
        return sin(angle) * 200
    }
    
}
