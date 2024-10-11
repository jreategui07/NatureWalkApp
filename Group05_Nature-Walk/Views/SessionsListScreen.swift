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
                            HStack {
                                AsyncImage(url: URL(string: session.photo)) { phase in
                                    switch phase {
                                        case .success(let image):
                                            image
                                                .resizable()
                                                .aspectRatio(contentMode: .fit)
                                                .frame(maxWidth: .infinity)
                                                .cornerRadius(12)
                                        case .empty:
                                        Image(systemName: "photo.on.rectangle.angled")
                                        case .failure(_ ):
                                        Image(systemName: "photo.on.rectangle.angled")
                                        default:
                                        Image(systemName: "photo.on.rectangle.angled")
                                    }
                                }
                                .frame(maxWidth: 120)
                                .listRowInsets(EdgeInsets())
                                
                                VStack(alignment: .leading, spacing: 0) {
                                    Text(session.name)
                                        .font(.headline)
                                    Text("$\(session.pricePerPerson, specifier: "%.2f") / person")
                                }
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
                photo: "https://i.pinimg.com/564x/fc/e3/a6/fce3a67885194f1aad99942b298e0018.jpg",
                pricePerPerson: 35.0),
    ]
    return SessionsListScreen().environmentObject(previewSessionManager)
}
