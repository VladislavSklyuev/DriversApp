//
//  DateHelper.swift
//  FirstGradProject2
//
//  Created by Владислав Склюев on 17.08.2023.
//

import Foundation

class DateHelper {
    private init() { }
    
    static func getDayTextFrom(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MMMM.yyyy"
        formatter.locale = Locale(identifier: "ru_RU")
        let str = formatter.string(from: date)
        return str
    }
    
}
