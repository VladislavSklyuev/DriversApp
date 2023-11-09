//
//  Car.swift
//  FirstGradProject2
//
//  Created by Владислав Склюев on 01.08.2023.
//

import Foundation
import FirebaseFirestore

struct Car: Identifiable, Hashable {
    var id: String = UUID().uuidString
    var brand: String
    var model: String
    //let isRent: Bool // собственная или парковая
    var year: Int
    var vinNumber: String
    var number: String
    var numberSts: Int
    var currentMileage: Int
    var color: String
    var status: Bool
    var oilChange: Int
    var brakePadsChange: Int
    var linksChange: Int
    var lastDateTO: Date
    var lastProbegInTO: Int
    var sparkPlugChange: Int
    var images: [Picture]
}

extension Car {
    init?(snapshot: QueryDocumentSnapshot) {
        let data = snapshot.data()
        guard let id = data["id"] as? String,
              let brand = data["brand"] as? String,
              let model = data["model"] as? String,
              let year = data["year"] as? Int,
              let vinNumber = data["vinNumber"] as? String,
              let number = data["number"] as? String,
              let numberSts = data["numberSts"] as? Int,
              let currentMileage = data["currentMileage"] as? Int,
              let status = data["status"] as? Bool,
              let oilChange = data["oilChange"] as? Int,
              let brakePadsChange = data["brakePadsChange"] as? Int,
              let linksChange = data["linksChange"] as? Int,
              let lastDateTO = data["lastDateTO"] as? Timestamp,
              let lastProbegInTO = data["lastProbegInTO"] as? Int,
              let sparkPlugChange = data["sparkPlugChange"] as? Int,
              let color = data["color"] as? String else { return nil }
              
        self.id = id
        self.brand = brand
        self.model = model
        self.year = year
        self.vinNumber = vinNumber
        self.number = number
        self.numberSts = numberSts
        self.currentMileage = currentMileage
        self.color = color
        self.status = status
        self.oilChange = oilChange
        self.brakePadsChange = brakePadsChange
        self.linksChange = linksChange
        self.lastDateTO = lastDateTO.dateValue()
        self.lastProbegInTO = lastProbegInTO
        self.sparkPlugChange = sparkPlugChange
        self.images = []
    }
}

extension Car {
    var representation: [String: Any] {
        var repres = [String: Any]()
        repres["id"] = id
        repres["brand"] = brand
        repres["model"] = model
        repres["year"] = year
        repres["vinNumber"] = vinNumber
        repres["number"] = number
        repres["numberSts"] = numberSts
        repres["currentMileage"] = currentMileage
        repres["color"] = color
        repres["status"] = status
        repres["oilChange"] = oilChange
        repres["brakePadsChange"] = brakePadsChange
        repres["linksChange"] = linksChange
        repres["lastDateTO"] = Timestamp(date: lastDateTO)
        repres["lastProbegInTO"] = lastProbegInTO
        repres["sparkPlugChange"] = sparkPlugChange
        return repres
    }
}
    



