//
//  PersistenceManager.swift
//  Group05_Nature-Walk
//
//  Created by Jonathan Reátegui on 2024-10-09.
//

import Foundation

class PersistenceManager {
    let userDefaults = UserDefaults.standard
    
    private let userKey = "savedUser"
    private let sessionKey = "sessionList"
    private let favoritesKey = "favoriteSessions"
    
    func saveUser(_ user: User) {
        if let encoded = try? JSONEncoder().encode(user) {
            userDefaults.set(encoded, forKey: userKey)
        }
    }

    func loadUser() -> User? {
        if let savedData = userDefaults.data(forKey: userKey),
           let decodedUser = try? JSONDecoder().decode(User.self, from: savedData) {
            return decodedUser
        }
        return nil
    }

    func clearUser() {
        userDefaults.removeObject(forKey: userKey)
    }

    func getAllSessions() -> [Session] {
        if let savedData = userDefaults.data(forKey: sessionKey),
           let decodedSessions = try? JSONDecoder().decode([Session].self, from: savedData) {
            return decodedSessions
        }
        return []
    }
    
    func saveFavoriteSessions(_ favorites: [Session]) {
        if let encoded = try? JSONEncoder().encode(favorites) {
            userDefaults.set(encoded, forKey: favoritesKey)
        }
    }
    
    func deleteFavoriteSession(withID id: UUID) {
        var favoriteSessions = getFavoriteSessions()
        favoriteSessions.removeAll { $0.id == id }
        if let encoded = try? JSONEncoder().encode(favoriteSessions) {
            userDefaults.set(encoded, forKey: sessionKey)
        }
    }

    func getFavoriteSessions() -> [Session] {
        if let savedData = userDefaults.data(forKey: favoritesKey),
           let decodedFavorites = try? JSONDecoder().decode([Session].self, from: savedData) {
            return decodedFavorites
        }
        return []
    }
}
