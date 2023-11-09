//
//  CarsCellViewModel.swift
//  FirstGradProject2
//
//  Created by Владислав Склюев on 01.08.2023.
//

import Foundation

class CarsCellViewModel: ObservableObject {
    @Published var position: Car
    
    init(position: Car) {
        self.position = position
    }
    
    func save(id: String) {
        position.id = id
        Task {
            try await FireStoreService.shared.setCarData(car: position)
        }
    }
}
