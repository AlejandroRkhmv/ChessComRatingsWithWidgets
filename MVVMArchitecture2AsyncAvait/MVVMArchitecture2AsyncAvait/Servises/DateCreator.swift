//
//  DateCreator.swift
//  MVVMArchitecture2AsyncAvait
//
//  Created by Александр Рахимов on 15.04.2023.
//

import Foundation

class DateCreator {
    static func dateString(from timeInterval: Int?) -> String {
        guard let timeInterval = timeInterval else { return ""}
        let interval = TimeInterval(timeInterval)
        let date = Date(timeIntervalSince1970: interval)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        let dateString = dateFormatter.string(from: date)
        return dateString
    }
}
