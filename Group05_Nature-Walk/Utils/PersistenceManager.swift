//
//  PersistenceManager.swift
//  Group05_Nature-Walk
//
//  Created by Jonathan Reátegui on 2024-10-09.
//

import SwiftUI

class PersistenceManager {
    let userDefaults = UserDefaults.standard
    
    private let userKey = "savedUser"
    private let sessionKey = "sessionList"
    
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
    
    func saveSession(_ session: Session) {
        var allSessions = getAllSessions()
        allSessions.append(session)
        if let encoded = try? JSONEncoder().encode(allSessions) {
            userDefaults.set(encoded, forKey: sessionKey)
        }
    }

    func getAllSessions() -> [Session] {
        if let savedData = userDefaults.data(forKey: sessionKey),
           let decodedSessions = try? JSONDecoder().decode([Session].self, from: savedData) {
            return decodedSessions
        }
        return []
    }
    
    func deleteSession(withID id: UUID) {
        var allSessions = getAllSessions()
        allSessions.removeAll { $0.id == id }
        if let encoded = try? JSONEncoder().encode(allSessions) {
            userDefaults.set(encoded, forKey: sessionKey)
        }
    }
    
    func updateSession(_ session: Session) {
        var allSessions = getAllSessions()
        if let index = allSessions.firstIndex(where: { $0.id == session.id }) {
            allSessions[index] = session
            if let encoded = try? JSONEncoder().encode(allSessions) {
                userDefaults.set(encoded, forKey: sessionKey)
            }
        }
    }
}
