//
//  DriverCellViewModel.swift
//  FirstGradProject2
//
//  Created by Владислав Склюев on 01.08.2023.
//

import Foundation

class DriverCellViewModel: ObservableObject {

    @Published var position: Driver
    
    init(position: Driver) {
        self.position = position
    }
    
    func save(id: String) {
                        Task {
                            let newDriver = Driver(id: id, surname: position.surname, name: position.name, lastname: position.lastname, birthDay: position.birthDay, numberPhone: position.numberPhone, numberDriverLicense: position.numberDriverLicense, dateOfdriverLic: position.dateOfdriverLic, driverLicExpDate: position.driverLicExpDate, raiting: position.raiting)
                            try await FireStoreService.shared.changeDriverData(driver: newDriver)
                        }
    }
}
