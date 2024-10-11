//
//  FavoritesListScreen.swift
//  Group05_Nature-Walk
//
//  Created by Jonathan Reátegui on 2024-10-11.
//

import SwiftUI

struct FavoritesListScreen: View {
    @EnvironmentObject var sessionManager: SessionManager

    var favoriteSessions: [Session] {
        return sessionManager.favoriteSessions
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                List {
                    ForEach(favoriteSessions) { session in
                        NavigationLink(destination: SessionDetailsScreen(session: session)) {
                            VStack(alignment: .leading) {
                                Text("Session ID: \(session.id)")
                                Text("Session Name: \(session.name)")
                                Text("Guide: \(session.guideName)")
                            }
                        }
                    }
                    .onDelete(perform: sessionManager.deleteFavoriteSession)
                }
            }
            .overlay(
                favoriteSessions.isEmpty ?
                Text("No sessions to display.")
                    .font(.headline)
                    .foregroundColor(.gray)
                : nil
            )
        }
    }
}

#Preview {
    FavoritesListScreen().environmentObject(SessionManager())
}

#Preview {
    let previewSessionManager = SessionManager()
    previewSessionManager.favoriteSessions = [
        Session(
            name: "Mountain Exploration",
            description: "A thrilling walk through the mountains, perfect for adventure seekers.",
            rating: 4.8,
            guideName: "John Doe",
            photo: "mountain_photo",
            pricePerPerson: 50.0
        ),
        Session(
            name: "City Park Stroll",
            description: "A relaxing walk through the city's largest park, great for families.",
            rating: 4.2,
            guideName: "Jane Smith",
            photo: "city_park_photo",
            pricePerPerson: 20.0
        )
    ]
    return FavoritesListScreen().environmentObject(previewSessionManager)
}
