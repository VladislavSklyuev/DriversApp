//
//  AuthorizationViewModel.swift
//  FirstGradProject2
//
//  Created by Владислав Склюев on 02.08.2023.
//

import Foundation
import LocalAuthentication
import Foundation

class AuthorizationViewModel: ObservableObject {
    @Published var login: String = ""
    @Published var password: String = ""
    @Published var confirm: String = ""
    
    @Published var isUnlocked = false    

    func auth(completion: @escaping ()->()) {
        Task {
            do {
                let user = try await AuthService.shared.signIn(with: login, password: password)
                print(user.uid)

                DispatchQueue.main.async {
                    completion()
                }
            
            } catch {
                print(error.localizedDescription)
            }
            
        }
    }
    
    func signUp(completion: @escaping () -> ()) {
        guard password == confirm else { return }
        guard password.count > 7 else { return }
        
        Task {
            let _ = try await AuthService.shared.signUp(email: self.login, password: self.password)
//            let profile = Profile(id: user.uid, name: "", surname: "", phone: 0, gender: true, age: 0)
//            try await FireStoreService.shared.changeUserData(profile: profile)
            DispatchQueue.main.async {
                completion()
            }
        }
    }
    
    func authenticate() {
        let context = LAContext()
        var error: NSError?
        
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let reason = "We need to unlock your"
            
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, authenticationError in
                if success {
                    self.isUnlocked = true
                } else {
                    
                }
            }
        } else {
            
        }
    }
    
}
