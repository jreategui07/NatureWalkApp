//
//  SessionManager.swift
//  Group05_Nature-Walk
//
//  Created by Jonathan Reátegui on 2024-10-09.
//

import Foundation

class SessionManager: ObservableObject {
    @Published var allSessions: [Session] = []
    @Published var favoriteSessions: [Session] = []

    let persistenceManager = PersistenceManager()

    init() {
        allSessions = [
            Session(name: "Mountain Exploration",
                    description: "A thrilling walk through the mountains, perfect for adventure seekers.",
                    rating: 4.8,
                    guideName: "John Doe",
                    photo: "https://img.freepik.com/premium-photo/inspiring-travel-adventure-mountain-exploration_985067-1306.jpg",
                    pricePerPerson: 50.0),
            Session(name: "City Park Stroll",
                    description: "A relaxing walk through the city's largest park, great for families.",
                    rating: 4.2,
                    guideName: "Jane Smith",
                    photo: "https://images.stockcake.com/public/c/5/d/c5dd0610-632d-4d77-aef2-66aa936f44a2_large/urban-park-stroll-stockcake.jpg",
                    pricePerPerson: 20.0),
            Session(name: "River Walk",
                    description: "Enjoy a serene walk along the river, perfect for nature lovers.",
                    rating: 4.6,
                    guideName: "Emily Brown",
                    photo: "https://images.squarespace-cdn.com/content/v1/5c3b68ae3917ee2af342b59d/1595692874908-ZAPVUZMIHZHFSKXL729L/thumbnail_13E931E5-0A1B-426D-8077-CDB1190C4C69.jpg",
                    pricePerPerson: 35.0),
        ]
        favoriteSessions = persistenceManager.getFavoriteSessions()
    }

    func addSession(_ session: Session) {
        allSessions.append(session)
        persistenceManager.saveSession(session)
    }

    func deleteSession(at offsets: IndexSet) {
        offsets.forEach { index in
            let sessionID = allSessions[index].id
            persistenceManager.deleteSession(withID: sessionID)
        }
        allSessions.remove(atOffsets: offsets)
    }

    func updateSession(_ session: Session) {
        if let index = allSessions.firstIndex(where: { $0.id == session.id }) {
            allSessions[index] = session
        }
    }
    
    func toggleFavorite(_ session: Session) {
        if let index = favoriteSessions.firstIndex(where: { $0.id == session.id }) {
            favoriteSessions.remove(at: index)
        } else {
            favoriteSessions.append(session)
        }
        persistenceManager.saveFavoriteSessions(favoriteSessions)
    }
}
