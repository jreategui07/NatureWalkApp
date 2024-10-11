//
//  HomeScreen.swift
//  Group05_Nature-Walk
//
//  Created by Jonathan Reátegui on 2024-10-10.
//

import SwiftUI

struct HomeScreen: View {
    @ObservedObject var loginManager: LoginManager
    @Environment(\.dismiss) var dismiss
    @State var isLoggedIn: Bool
    @State private var showLogoutConfirmation = false
    @State private var selectedTab: HomeTab = .allSessions
    
    var body: some View {
        NavigationStack {
            VStack {
                TabView(selection: $selectedTab) {
                    SessionsListScreen()
                        .tabItem {
                            Image(systemName: "list.bullet")
                            Text("All Sessions")
                        }
                        .tag(HomeTab.allSessions)
                    FavoritesListScreen()
                        .tabItem {
                            Image(systemName: "star.fill")
                            Text("Favorites Sessions")
                        }
                        .tag(HomeTab.favoriteSessions)
                }
            }
            .navigationTitle(navigationTitle(for: selectedTab))
            .navigationBarTitleDisplayMode(.large)
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    Button {
                        showLogoutConfirmation = true
                    } label: {
                        Text("Sign Out")
                            .font(.subheadline)
                    }
                    .alert(isPresented: $showLogoutConfirmation) {
                        Alert(
                            title: Text("Are you sure you want to sign out?"),
                            primaryButton: .destructive(Text("Yes")) {
                                logout()
                            },
                            secondaryButton: .cancel(Text("No"))
                        )
                    }
                }
            }
        }
    }
    
    private func navigationTitle(for tab: HomeTab) -> String {
        switch tab {
        case .allSessions:
            return "All Sessions"
        case .favoriteSessions:
            return "Favorite Sessions"
        }
    }
    
    private func logout() {
        loginManager.logout()
        isLoggedIn = false
        dismiss()
    }
}

#Preview {
    HomeScreen(loginManager: LoginManager(), isLoggedIn: true).environmentObject(SessionManager())
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
    ]
    return HomeScreen(loginManager: LoginManager(), isLoggedIn: true).environmentObject(previewSessionManager)
}
