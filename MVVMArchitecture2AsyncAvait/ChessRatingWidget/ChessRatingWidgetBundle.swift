//
//  ChessRatingWidgetBundle.swift
//  ChessRatingWidget
//
//  Created by Александр Рахимов on 17.04.2023.
//

import WidgetKit
import SwiftUI

@main
struct ChessRatingWidgetBundle: WidgetBundle {
    var body: some Widget {
        ChessRatingWidget()
        ChessRatingWidgetLiveActivity()
    }
}
