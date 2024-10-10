//
//  PersistenceManager.swift
//  Group05_Nature-Walk
//
//  Created by Jonathan Reátegui on 2024-10-09.
//

import Foundation

class PersistenceManager {
    let userDefaults = UserDefaults.standard
    
    func saveCurrentUser(user: User) {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(user) {
            userDefaults.set(encoded, forKey: "currentUser")
        }
    }
    
    func loadCurrentUser() -> User? {
        if let savedUserData = userDefaults.data(forKey: "currentUser") {
            let decoder = JSONDecoder()
            if let loadedUser = try? decoder.decode(User.self, from: savedUserData) {
                return loadedUser
            }
        }
        return nil
    }
    
    func saveFavorites(favorites: [Session]) {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(favorites) {
            userDefaults.set(encoded, forKey: "favorites")
        }
    }
    
    func loadFavorites() -> [Session] {
        if let savedFavoritesData = userDefaults.data(forKey: "favorites") {
            let decoder = JSONDecoder()
            if let loadedFavorites = try? decoder.decode([Session].self, from: savedFavoritesData) {
                return loadedFavorites
            }
        }
        return []
    }
}
