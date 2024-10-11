//
//  FavoritesListScreen.swift
//  Group05_Nature-Walk
//
//  Created by Jonathan Reátegui on 2024-10-11.
//

import SwiftUI

struct FavoritesListScreen: View {
    @EnvironmentObject var sessionManager: SessionManager
    @State private var clearFavoriteList = false

    var favoriteSessions: [Session] {
        return sessionManager.favoriteSessions
    }
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                List {
                    if (!favoriteSessions.isEmpty) {
                        Button {
                            clearFavoriteList = true
                        } label: {
                            Text("Clear All")
                                .font(.subheadline)
                                .foregroundColor(.red)
                        }
                        .alert(isPresented: $clearFavoriteList) {
                            Alert(
                                title: Text("Are you sure you want to clear al your favorite list?"),
                                primaryButton: .destructive(Text("Yes")) {
                                    sessionManager.deleteAllFavoriteSessions()
                                },
                                secondaryButton: .cancel(Text("No"))
                            )
                        }
                    }
                    
                    ForEach(favoriteSessions) { session in
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
    ]
    return FavoritesListScreen().environmentObject(previewSessionManager)
}
