//
//  SessionDetailsScreen.swift
//  Group05_Nature-Walk
//
//  Created by Jonathan Reátegui on 2024-10-09.
//

import SwiftUI

struct SessionDetailsScreen: View {
    @EnvironmentObject var sessionManager: SessionManager
    @State var session: Session
    var body: some View {
        Text("\(session.name)")
    }
}

#Preview {
    SessionDetailsScreen(session: Session(
        name: "Mountain Exploration",
        description: "A thrilling walk through the mountains, perfect for adventure seekers.",
        rating: 4.8,
        guideName: "John Doe",
        photo: "mountain_photo",
        pricePerPerson: 50.0
    )).environmentObject(SessionManager())
}
