//
//  Picture.swift
//  TrainingBooking
//
//  Created by Владислав Склюев on 16.08.2023.
//

import Foundation
import FirebaseFirestore

struct Picture: Identifiable, Hashable {
    let id: String
    //let title: String
}

extension Picture {
    init?(snapshot: QueryDocumentSnapshot) {
        let data = snapshot.data()
        guard let id = data["id"] as? String else { return nil }
              //let title = data["title"] as? String
              
        self.id = id
        //self.title = title

    }
}

extension Picture {
    var representation: [String: Any] {
        var repres = [String: Any]()
        repres["id"] = id
        //repres["title"] = title
        return repres
    }
}
