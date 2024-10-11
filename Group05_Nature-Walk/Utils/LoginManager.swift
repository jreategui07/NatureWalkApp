//
//  LoginManager.swift
//  Group05_Nature-Walk
//
//  Created by Jonathan Reátegui on 2024-10-09.
//

import SwiftUI

class LoginManager: ObservableObject {
    @Published var currentUser: User?
    let persistenceManager = PersistenceManager()

    func validateCredentials(email: String, password: String) -> Bool {
        let predefinedUsers = [
            User(email: "test@gmail.com", password: "test123"),
            User(email: "admin@gmail.com", password: "admin123")
        ]
        
        if let user = predefinedUsers.first(where: { $0.email == email && $0.password == password }) {
            currentUser = user
            persistenceManager.saveUser(user) // Guardamos el usuario en UserDefaults
            return true
        }
        return false
    }
    
    func saveCredentials(email: String, password: String) {
        UserDefaults.standard.set(email, forKey: "savedEmail")
        UserDefaults.standard.set(password, forKey: "savedPassword")
        UserDefaults.standard.set(true, forKey: "rememberMe")
    }
    
    func loadCredentials() -> User? {
        if let savedUser = persistenceManager.loadUser() {
            currentUser = savedUser
            return savedUser
        }
        return nil
    }
    
    func clearCredentials() {
        persistenceManager.clearUser()
        currentUser = nil
    }
    
    func logout() {
        currentUser = nil
    }
}
