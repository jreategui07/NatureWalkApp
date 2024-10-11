//
//  SessionsListScreen.swift
//  Group05_Nature-Walk
//
//  Created by Jonathan Reátegui on 2024-10-09.
//

import SwiftUI

struct SessionsListScreen: View {
    @State var filterFavorites: Bool = false
    @EnvironmentObject var sessionManager: SessionManager

    var allSessions: [Session] {
        return sessionManager.allSessions
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                List {
                    ForEach(allSessions) { session in
                        NavigationLink(destination: SessionDetailsScreen(session: session)) {
                            VStack(alignment: .leading) {
                                Text("Session ID: \(session.id)")
                                Text("Session Name: \(session.name)")
                                Text("Guide: \(session.guideName)")
                            }
                        }
                    }
                }
            }
            .overlay(
                allSessions.isEmpty ?
                Text("No sessions to display.")
                    .font(.headline)
                    .foregroundColor(.gray)
                : nil
            )
        }
    }
}

#Preview {
    SessionsListScreen().environmentObject(SessionManager())
}

#Preview {
    let previewSessionManager = SessionManager()
    previewSessionManager.allSessions = [
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
    return SessionsListScreen().environmentObject(previewSessionManager)
}
