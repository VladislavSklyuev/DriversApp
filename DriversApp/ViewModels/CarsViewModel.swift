//
//  CarsViewModel.swift
//  FirstGradProject2
//
//  Created by Владислав Склюев on 01.08.2023.
//

import Foundation

class CarsViewModel: ObservableObject {
    @Published var cars = [Car]()
    
    init() {
        getCars()
    }
    
    func getCars() {
        Task {
            let cars = try await FireStoreService.shared.getCars()
            DispatchQueue.main.async {
                self.cars = cars
            }
        }
    }
    
    func deleteCar(id: String) {
        Task {
            try await FireStoreService.shared.deleteCar(id: id)
            DispatchQueue.main.async {
                self.getCars()
            }
        }
    }
}
