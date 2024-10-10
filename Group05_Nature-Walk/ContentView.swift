//
//  ContentView.swift
//  Group05_Nature-Walk
//
//  Created by Jonathan Reátegui on 2024-10-09.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var loginManager = LoginManager()
    
    var body: some View {
//            if loginManager.currentUser != nil { // Displaying SessionsListScreen if there is a logged in user
//                SessionsListScreen(loginManager: loginManager, isLoggedIn: true)
//            } else {
//                // if there is not logged in user go to LoginScreen
                LoginScreen(loginManager: loginManager)
//            }
    }
}

#Preview {
    ContentView()
}
