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
                    photos: [
                        "https://img.freepik.com/premium-photo/inspiring-travel-adventure-mountain-exploration_985067-1306.jpg",
                        "https://media.istockphoto.com/id/612619528/photo/hippie-woman-stroll-on-mountain.jpg?s=612x612&w=0&k=20&c=itnF_PSwxpOZGwi6_bEN217prgXIKNNN2UZzIpYLsNk="
                    ],
                    pricePerPerson: 50.0),
            Session(name: "City Park Stroll",
                    description: "A relaxing walk through the city's largest park, great for families.",
                    rating: 4.2,
                    guideName: "Jane Smith",
                    photos: [
                        "https://images.stockcake.com/public/c/5/d/c5dd0610-632d-4d77-aef2-66aa936f44a2_large/urban-park-stroll-stockcake.jpg",
                        "https://media.istockphoto.com/id/1355338628/photo/family-strolling-in-the-late-afternoon-in-the-city-park.jpg?s=612x612&w=0&k=20&c=k9KkEifTbgyLtil8qONWKjxie7wZj8SKfZIqQ3OnbEQ="
                    ],
                    pricePerPerson: 20.0),
            Session(name: "River Walk",
                    description: "Enjoy a serene walk along the river, perfect for nature lovers.",
                    rating: 4.6,
                    guideName: "Emily Brown",
                    photos: [
                        "https://i.pinimg.com/564x/fc/e3/a6/fce3a67885194f1aad99942b298e0018.jpg",
                        "https://www.shutterstock.com/image-photo/couple-hiking-along-path-by-600nw-1188689026.jpg"
                    ],
                    pricePerPerson: 35.0),
        ]
        favoriteSessions = persistenceManager.getFavoriteSessions()
    }

    func updateSession(_ session: Session) {
        if let index = allSessions.firstIndex(where: { $0.id == session.id }) {
            allSessions[index] = session
        }
    }
    
    func deleteFavoriteSession(at offsets: IndexSet) {
        offsets.forEach { index in
            let sessionID = favoriteSessions[index].id
            persistenceManager.deleteFavoriteSession(withID: sessionID)
        }
        favoriteSessions.remove(atOffsets: offsets)
        persistenceManager.saveFavoriteSessions(favoriteSessions)
    }
    
    func toggleFavorite(_ session: Session) {
        if let index = favoriteSessions.firstIndex(where: { $0.id == session.id }) {
            favoriteSessions.remove(at: index)
        } else {
            favoriteSessions.append(session)
        }
        persistenceManager.saveFavoriteSessions(favoriteSessions)
    }
    
    func deleteAllFavoriteSessions() {
        favoriteSessions.removeAll()
        persistenceManager.saveFavoriteSessions(favoriteSessions)
    }
}
