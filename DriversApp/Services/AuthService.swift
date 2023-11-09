//
//  AuthService.swift
//  FirstGradProject2
//
//  Created by Владислав Склюев on 10.08.2023.
//

import Foundation
import FirebaseAuth

class AuthService {
    
    static let shared = AuthService(); private init() { }
    
    private let auth = Auth.auth()
    
    var currentUser: User? { auth.currentUser }
    
    func signIn(with email: String, password: String) async throws -> User {
        let result = try await auth.signIn(withEmail: email, password: password)
        let user = result.user
        return user
    }
    
    func signUp(email: String, password: String) async throws -> User {
        let result = try await auth.createUser(withEmail: email, password: password)
        let user = result.user
        return user
    }
    
    func signOut() {
        do {
            try auth.signOut()
        } catch {
            print(error.localizedDescription)
        }
    }
    
}
