//
//  ContentViewModel.swift
//  FirstGradProject2
//
//  Created by Владислав Склюев on 15.08.2023.
//


import Foundation
import FirebaseAuth

class ContentViewModel: ObservableObject {
    @Published var currentUser: User?
    @Published var profile: Profile?
    
    
    init() {
        self.currentUser = AuthService.shared.currentUser
    }
    

}
