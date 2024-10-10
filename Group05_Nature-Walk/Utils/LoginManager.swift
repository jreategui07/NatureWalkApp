//
//  LoginManager.swift
//  Group05_Nature-Walk
//
//  Created by Jonathan Reátegui on 2024-10-09.
//

import Foundation

class LoginManager: ObservableObject {
    @Published var currentUser: User?

    func validateCredentials(email: String, password: String) -> Bool {
        let predefinedUsers = [
            User(email: "test@gmail.com", password: "test123"),
            User(email: "admin@gmail.com", password: "admin123")
        ]
        
        if let user = predefinedUsers.first(where: { $0.email == email && $0.password == password }) {
            currentUser = user
            return true
        }
        return false
    }
    
    func saveCredentials(email: String, password: String) {
        UserDefaults.standard.set(email, forKey: "savedEmail")
        UserDefaults.standard.set(password, forKey: "savedPassword")
        UserDefaults.standard.set(true, forKey: "rememberMe")
    }
    
    func loadCredentials() -> (email: String, password: String)? {
        let rememberMe = UserDefaults.standard.bool(forKey: "rememberMe")
        if rememberMe {
            if let email = UserDefaults.standard.string(forKey: "savedEmail"),
               let password = UserDefaults.standard.string(forKey: "savedPassword") {
                return (email, password)
            }
        }
        return nil
    }
    
    func clearCredentials() {
        UserDefaults.standard.removeObject(forKey: "savedEmail")
        UserDefaults.standard.removeObject(forKey: "savedPassword")
        UserDefaults.standard.set(false, forKey: "rememberMe")
    }
    
    func logout() {
        currentUser = nil
    }
}
