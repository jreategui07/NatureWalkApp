//
//  SessionsListScreen.swift
//  Group05_Nature-Walk
//
//  Created by Jonathan Reátegui on 2024-10-09.
//

import SwiftUI

struct SessionsListScreen: View {
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
                                AsyncImage(url: URL(string: session.photos[0])) { phase in
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
    return SessionsListScreen().environmentObject(previewSessionManager)
}
