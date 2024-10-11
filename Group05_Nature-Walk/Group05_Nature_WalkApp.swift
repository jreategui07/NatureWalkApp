//
//  Group05_Nature_WalkApp.swift
//  Group05_Nature-Walk
//
//  Created by Jonathan Reátegui on 2024-10-09.
//

import SwiftUI

@main
struct Group05_Nature_WalkApp: App {
    @StateObject private var sessionManager = SessionManager()
    
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(sessionManager)
        }
    }
}
