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
        /**
         Uncomenting this code, we can automatically go to the home screen if the user is logged in
         */
//        if loginManager.currentUser != nil {
//            HomeScreen(loginManager: loginManager, isLoggedIn: true)
//        } else {
            LoginScreen(loginManager: loginManager)
//        }
    }
}

#Preview {
    ContentView()
}
