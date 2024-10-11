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
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 20) {
                TabView {
                    SessionsListScreen()
                        .tabItem {
                            Image(systemName: "list.bullet")
                            Text("All Sessions")
                        }
                    FavoritesListScreen()
                        .tabItem {
                            Image(systemName: "star.fill")
                            Text("Favorites Sessions")
                        }
                }
            }
            .padding()
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
    
    private func logout() {
        loginManager.logout()
        isLoggedIn = false
        dismiss()
    }
}

#Preview {
    let loginManager = LoginManager()
    return HomeScreen(loginManager: loginManager, isLoggedIn: true)
}
