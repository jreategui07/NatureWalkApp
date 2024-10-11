//
//  User.swift
//  Group05_Nature-Walk
//
//  Created by Jonathan Reátegui on 2024-10-09.
//

import SwiftUI

class User: Identifiable, Codable {
    var id = UUID()
    var email: String
    var password: String
    var rememberMe: Bool
    var favorites: [Session] = []
    
    init(email: String, password: String, rememberMe: Bool = false) {
        self.email = email
        self.password = password
        self.rememberMe = rememberMe
    }
    
    func addToFavorites(session: Session) {
        if !favorites.contains(where: { $0.id == session.id }) {
            favorites.append(session)
        }
    }
    
    func removeFromFavorites(session: Session) {
        favorites.removeAll(where: { $0.id == session.id })
    }
}
