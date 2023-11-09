//
//  AddCarViewModel.swift
//  FirstGradProject2
//
//  Created by Владислав Склюев on 02.08.2023.
//

import Foundation

class AddCarViewModel: ObservableObject {
    @Published var brand: String = ""
    @Published var model: String = ""
    @Published var isRent: Bool = true
    @Published var year: Int?
    @Published var number: String = ""
    @Published var vinNumber: String = ""
    @Published var numberSts: Int?
    @Published var currentMileage: Int?
    @Published var color: String = ""

    func save() {
        Task {
            let newCar = Car(brand: brand, model: model, year: year ?? 0, vinNumber: vinNumber, number: number, numberSts: numberSts ?? 0, currentMileage: currentMileage ?? 0, color: color, status: true, oilChange: 0, brakePadsChange: 0, linksChange: 0, lastDateTO: .now, lastProbegInTO: 0, sparkPlugChange: 0, images: [])
            try await FireStoreService.shared.setCarData(car: newCar)
        }
    }
}

