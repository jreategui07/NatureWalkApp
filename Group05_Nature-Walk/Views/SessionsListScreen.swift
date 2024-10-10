//
//  SessionsListScreen.swift
//  Group05_Nature-Walk
//
//  Created by Jonathan Reátegui on 2024-10-09.
//

import SwiftUI

struct SessionsListScreen: View {
    
    @Environment(\.dismiss) var dismiss
    @ObservedObject var loginManager: LoginManager
    @State var isLoggedIn: Bool
    @State private var showLogoutConfirmation = false
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 20) {
                Text("SessionsListScreen")
                    .font(.largeTitle)
                    .bold()
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
    return SessionsListScreen(loginManager: loginManager, isLoggedIn: true)
}
