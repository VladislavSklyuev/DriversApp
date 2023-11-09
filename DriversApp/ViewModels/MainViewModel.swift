//
//  MainViewModel.swift
//  FirstGradProject2
//
//  Created by Владислав Склюев on 15.08.2023.
//

import LocalAuthentication
import Foundation
import FirebaseAuth

class MainViewModel: ObservableObject {
    @Published var isUnlocked = false
    var user: User?
    
    @Published var profile: Profile?
    
    init(user: User?) {
        self.user = user
        
        Task {
            let profile = try await FireStoreService.shared.getUserData(id: self.user!.uid)
            DispatchQueue.main.async {
                self.profile = profile
            }
        }
    }
    
    func signOut(completion: @escaping ()->()) {
        AuthService.shared.signOut()
        completion()
    }
    
    func authenticate() {
        let context = LAContext()
        var error: NSError?
        
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let reason = "We need to unlock your data"
            
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, authenticationError in
                if success {
                    DispatchQueue.main.async {
                        
                        self.isUnlocked = true
                    }
                } else {
                    
                }
            }
        } else {
            
        }
    }
}
