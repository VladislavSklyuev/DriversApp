//
//  Profile.swift
//  FirstGradProject2
//
//  Created by Владислав Склюев on 15.08.2023.
//

import Foundation
import FirebaseFirestore

struct Profile: Identifiable, Equatable {
    var id: String = UUID().uuidString
    var name: String
    var surname: String
    var phone: Int
    var gender: Bool
    var age: Int
    
}

extension Profile {
    init?(snapshot: DocumentSnapshot) {
        guard let data = snapshot.data() else { return nil }
        guard let id = data["id"] as? String,
              let name = data["name"] as? String,
              let surname = data["surname"] as? String,
              let phone = data["phone"] as? Int,
              let gender = data["gender"] as? Bool,
              let age = data["age"] as? Int else { return nil }
              
        self.id = id
        self.name = name
        self.surname = surname
        self.phone = phone
        self.gender = gender
        self.age = age
    }
}

extension Profile {
    var representation: [String: Any] {
        var repres = [String: Any]()
        repres["id"] = id
        repres["name"] = name
        repres["surname"] = surname
        repres["phone"] = phone
        repres["gender"] = gender
        repres["age"] = age
        return repres
    }
}
