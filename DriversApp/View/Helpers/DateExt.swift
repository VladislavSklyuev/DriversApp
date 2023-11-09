//
//  DateExt.swift
//  FirstGradProject2
//
//  Created by Владислав Склюев on 04.08.2023.
//

import Foundation

extension Date {
    
    func format() -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ru_RU")
        formatter.setLocalizedDateFormatFromTemplate("MMMMd yyyy")
        //formatter.dateFormat = "dd.MMMM.yyyy"
        
        return formatter.string(from: self)
    }
}
