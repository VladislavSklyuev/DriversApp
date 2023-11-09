//
//  StringExt.swift
//  FirstGradProject2
//
//  Created by Владислав Склюев on 23.08.2023.
//

import Foundation

extension String {
    func formattedMask(_ text: String, mask: String?) -> String {
        let cleanPhoneNumber = text.components(separatedBy: CharacterSet.decimalDigits.inverted)
            .joined()
        var result = ""
        var index = cleanPhoneNumber.startIndex
        if let mask {
            for ch in mask where index < cleanPhoneNumber.endIndex {
                if ch == "X" {
                    result.append(cleanPhoneNumber[index])
                    index = cleanPhoneNumber.index(after: index)
                } else {
                    result.append(ch)
                }
            }
        }
        return result
    }
}

