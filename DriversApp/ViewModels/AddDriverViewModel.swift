//
//  AddDriverViewModel.swift
//  FirstGradProject2
//
//  Created by Владислав Склюев on 01.08.2023.
//

import Foundation

class AddDriverViewModel: ObservableObject {
    @Published var surname: String = ""
    @Published var name: String = ""
    @Published var lastname: String = ""
    @Published var birthday: Date = .now
    @Published var numberDriverLicense: String = ""
    @Published var dateOfdriverLic: Date = .now
    @Published var driverLicExpDate: Date = .now
    @Published var numberPhone: String = ""
    @Published var raiting: Double?
    @Published var status: Bool = true
    
    
    func save() {
        
        Task {
            let newDriver = Driver(surname: surname, name: name, lastname: lastname, birthDay: birthday, numberPhone: numberPhone, numberDriverLicense: numberDriverLicense, dateOfdriverLic: dateOfdriverLic, driverLicExpDate: driverLicExpDate, raiting: raiting ?? 5)
            try await FireStoreService.shared.changeDriverData(driver: newDriver)
        }
    }
}
