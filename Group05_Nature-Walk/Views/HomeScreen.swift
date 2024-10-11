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
                            .foregroundColor(.red)
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
    return HomeScreen(loginManager: LoginManager(), isLoggedIn: true).environmentObject(previewSessionManager)
}
