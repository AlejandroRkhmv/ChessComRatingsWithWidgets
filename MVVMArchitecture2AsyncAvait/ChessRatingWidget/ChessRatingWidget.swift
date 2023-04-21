//
//  ChessRatingWidget.swift
//  ChessRatingWidget
//
//  Created by Александр Рахимов on 17.04.2023.
//

import WidgetKit
import SwiftUI

struct Provider: TimelineProvider {
    @AppStorage("user", store: UserDefaults.group) var userForWidget = Data()
    @AppStorage("typeOfRating", store: UserDefaults.group) var typeOfRating = String()
    @AppStorage("dailyData", store: UserDefaults.group) var dailyData = Data()
    
    func placeholder(in context: Context) -> SimpleEntry {
        let user = DecoderEncoderSupport.decodeUser(from: userForWidget)
        let daily = DecoderEncoderSupport.decodeParty(from: dailyData)
        guard let userName = user.name,
              let rapidRating = user.rapid,
              let blitzRating = user.blitz,
              let bulletRating = user.bullet,
              let dailyRating = user.daily,
              let tacticRating = user.tactic,
              let white = daily.white,
              let black = daily.black,
              let moves = daily.moves,
              let typeOfparty = daily.typeOfParty
        else { return SimpleEntry(date: Date(), user: "", rapidRating: "", blitzRating: "", bulletRating: "", dailyRating: "", tacticRating: "", type: "", dailyUserWhite: "", dailyUserBlack: "", moves: "", typeOfParty: "") }
        return SimpleEntry(date: Date(), user: userName, rapidRating: "\(rapidRating)", blitzRating: "\(blitzRating)", bulletRating: "\(bulletRating)", dailyRating: "\(dailyRating)", tacticRating: "\(tacticRating)", type: typeOfRating, dailyUserWhite: white, dailyUserBlack: black, moves: moves, typeOfParty: typeOfparty)
    }

    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let user = DecoderEncoderSupport.decodeUser(from: userForWidget)
        let daily = DecoderEncoderSupport.decodeParty(from: dailyData)
        guard let userName = user.name,
              let rapidRating = user.rapid,
              let blitzRating = user.blitz,
              let bulletRating = user.bullet,
              let dailyRating = user.daily,
              let tacticRating = user.tactic,
              let white = daily.white,
              let black = daily.black,
              let moves = daily.moves,
              let typeOfparty = daily.typeOfParty else { return }
        let entry = SimpleEntry(date: Date(), user: userName, rapidRating: "\(rapidRating)", blitzRating: "\(blitzRating)", bulletRating: "\(bulletRating)", dailyRating: "\(dailyRating)", tacticRating: "\(tacticRating)", type: typeOfRating, dailyUserWhite: white, dailyUserBlack: black, moves: moves, typeOfParty: typeOfparty)
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 10 {
            let components = DateComponents(second: hourOffset)
            let reload = Calendar.current.date(byAdding: components, to: currentDate)!
            let user = DecoderEncoderSupport.decodeUser(from: userForWidget)
            let daily = DecoderEncoderSupport.decodeParty(from: dailyData)
            guard let userName = user.name,
                  let rapidRating = user.rapid,
                  let blitzRating = user.blitz,
                  let bulletRating = user.bullet,
                  let dailyRating = user.daily,
                  let tacticRating = user.tactic,
                  let white = daily.white,
                  let black = daily.black,
                  let moves = daily.moves,
                  let typeOfparty = daily.typeOfParty else { return }
            let entry = SimpleEntry(date: reload, user: userName, rapidRating: "\(rapidRating)", blitzRating: "\(blitzRating)", bulletRating: "\(bulletRating)", dailyRating: "\(dailyRating)", tacticRating: "\(tacticRating)", type: typeOfRating, dailyUserWhite: white, dailyUserBlack: black, moves: moves, typeOfParty: typeOfparty)
            entries.append(entry)
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let user: String
    let rapidRating: String
    let blitzRating: String
    let bulletRating: String
    let dailyRating: String
    let tacticRating: String
    let type: String
    let dailyUserWhite: String
    let dailyUserBlack: String
    let moves: String
    let typeOfParty: String
}

struct ChessRatingWidgetEntryView: View {
    var entry: Provider.Entry
    
    @Environment(\.widgetFamily) var widgetFamily
    
    var body: some View {
        switch widgetFamily {
            // MARK: - small widget - only choosed ratin
        case .systemSmall:
            GeometryReader { geometry in
                
                let width = geometry.frame(in: .local).width
                let height = geometry.frame(in: .local).height
                
                ZStack {
                    Color("background")
                    RoundedRectangle(cornerRadius: 20)
                        .frame(width: width * 0.85, height: height * 0.85, alignment: .center)
                        .foregroundColor(Color("background"))
                        .shadow(color: Color("text"), radius: 10, x: 0, y: 0)
                    VStack {
                        Text(entry.type)
                            .foregroundColor(.white)
                            .font(.custom("Courier", size: 20))
                        Text(setRating(type: entry.type))
                            .foregroundColor(.white)
                            .font(.custom("Courier", size: 40))
                    }
                }
            }
            
            // MARK: - medium vidget - choosed correspondence party and last move
        case .systemMedium:
            GeometryReader { geometry in
                
                let width = geometry.frame(in: .local).width
                let height = geometry.frame(in: .local).height
                
                ZStack {
                    Color("background")
                    RoundedRectangle(cornerRadius: 20)
                        .frame(width: width * 0.9, height: height * 0.85, alignment: .center)
                        .foregroundColor(Color("background"))
                        .shadow(color: Color("text"), radius: 10, x: 0, y: 0)
                    VStack {
                        Text(entry.typeOfParty)
                            .bold()
                            .font(.system(size: 30))
                            .position(x: width * 0.2, y: height * 0.2)
                        Group {
                            HStack {
                                Text(entry.dailyUserWhite)
                                    .foregroundColor(.white)
                                Text("vs")
                                    .font(.system(size: 10))
                                Text(entry.dailyUserBlack)
                                    .foregroundColor(.black)
                            }
                            .position(x: width * 0.5)
                        }
                        .padding(.top, 10)
                        
                        Text(entry.moves)
                            .font(.system(size: 20))
                            .position(x: width * 0.5, y: 0)
                    }
                    .foregroundColor(.white)
                }
            }
            
            // MARK: - large widget - all ratings
        case .systemLarge:
            GeometryReader { geometry in
                
                let width = geometry.frame(in: .local).width
                let height = geometry.frame(in: .local).height
                
                ZStack {
                    Color("background")
                    RoundedRectangle(cornerRadius: 20)
                        .frame(width: width * 0.85, height: height * 0.85, alignment: .center)
                        .foregroundColor(Color("background"))
                        .shadow(color: Color("text"), radius: 10, x: 0, y: 0)
                    VStack {
                        Text(entry.user)
                            .foregroundColor(.white)
                            .font(.custom("Courier", size: 40))
                        HStack {
                            Text("rapid:")
                            Text(entry.rapidRating)
                        }
                        .foregroundColor(.white)
                        .font(.custom("Courier", size: 15))
                        
                        HStack {
                            Text("blitz:")
                            Text(entry.blitzRating)
                        }
                        .foregroundColor(.white)
                        .font(.custom("Courier", size: 15))
                        
                        HStack {
                            Text("bullet:")
                            Text(entry.bulletRating)
                        }
                        .foregroundColor(.white)
                        .font(.custom("Courier", size: 15))
                        
                        HStack {
                            Text("daily:")
                            Text(entry.dailyRating)
                        }
                        .foregroundColor(.white)
                        .font(.custom("Courier", size: 15))
                        
                        HStack {
                            Text("tactic:")
                            Text(entry.tacticRating)
                        }
                        .foregroundColor(.white)
                        .font(.custom("Courier", size: 15))
                    }
                }
            }
        default:
            ZStack {
                Text("Default")
            }
        }
    }
        
    
    // MARK: - function
    
    func setRating(type: String) -> String {
        switch type {
        case "rapid":
            return entry.rapidRating
        case "blitz":
            return entry.blitzRating
        case "bullet":
            return entry.bulletRating
        case "daily":
            return entry.dailyRating
        case "tactic":
            return entry.tacticRating
        default:
            return ""
        }
    }
}

struct ChessRatingWidget: Widget {
    let kind: String = "ChessRatingWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            ChessRatingWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("Chess widget")
        .description("This is an user rating widget")
        .supportedFamilies([.systemMedium, .systemSmall, .systemLarge])
    }
}

extension UserDefaults {
  static let group = UserDefaults(suiteName: "group.com.AlejandroRkhmv.MVVMArchitecture2AsyncAvait.ChessRatingWidget")!
}
