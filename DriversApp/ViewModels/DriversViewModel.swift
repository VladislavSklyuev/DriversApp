//
//  DriversViewModel.swift
//  FirstGradProject2
//
//  Created by Владислав Склюев on 01.08.2023.
//

import Foundation
import UIKit

class DriversViewModel: ObservableObject {
    @Published var drivers = [Driver]()
   
    
    init() {
        getDrivers()
    }
    
    func getDrivers() {
        Task {
            let drivers = try await FireStoreService.shared.getDrivers()
            DispatchQueue.main.async {
                self.drivers = drivers
            }
        }
    }
    
    func deleteDriver(id: String) {
        Task {
            try await FireStoreService.shared.deleteDriver(id: id)
            DispatchQueue.main.async {
                self.getDrivers()
            }
        }
    }
    
    func callForHelp(_ number: String) {
        let url = URL(string: "tel://+7\(number)")!
        if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url)
        }
    }
}
