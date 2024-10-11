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
        VStack(alignment: .leading, spacing: 20) {
            AsyncImage(url: URL(string: session.photo)) { phase in
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
            .frame(maxWidth: .infinity, alignment: .center)
            .listRowInsets(EdgeInsets())
            
            Text(session.description)
                .font(.body)
            
            HStack {
                Text("Rating:").font(.headline)
                Text("\(session.rating, specifier: "%.1f") / 5")
            }
            
            HStack {
                Text("Guide/Organization:").font(.headline)
                Button(action: {
                    makeCall(to: "+1000000000") // mock phone number
                }) {
                    Text(session.guideName).foregroundColor(.blue)
                }
            }
            
            HStack {
                Text("Price per person:").font(.headline)
                Text("$\(session.pricePerPerson, specifier: "%.2f")")
            }

            Button(action: {
                sessionManager.toggleFavorite(session)
            }) {
                Text(sessionManager.favoriteSessions.contains(where: { $0.id == session.id }) ? "Remove from Favorites" : "Add to Favorites")
                    .font(.headline)
                    .padding()
                    .background(sessionManager.favoriteSessions.contains(where: { $0.id == session.id }) ? Color.red : Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }

            Button(action: {
                shareSession(session)
            }) {
                HStack {
                    Image(systemName: "square.and.arrow.up")
                    Text("Share Session")
                }
                .font(.headline)
                .padding()
                .background(Color.green)
                .foregroundColor(.white)
                .cornerRadius(10)
            }

            Spacer()
        }
        .padding()
        .navigationTitle(session.name)
    }

    private func shareSession(_ session: Session) {
        let text = "Check out this session: \(session.name)! It costs $\(session.pricePerPerson) per person."
        let activityController = UIActivityViewController(
            activityItems: [text],
            applicationActivities: nil
        )
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
            windowScene.windows.first?.rootViewController?.present(activityController, animated: true, completion: nil)
        }
    }
    
    private func makeCall(to phoneNumber: String) {
        print("Calling to: \(phoneNumber)")
        if let phoneURL = URL(string: "tel://\(phoneNumber)"),
           UIApplication.shared.canOpenURL(phoneURL) {
            UIApplication.shared.open(phoneURL, options: [:], completionHandler: nil)
        }
    }
}

#Preview {
    SessionDetailsScreen(session: Session(
        name: "Mountain Exploration",
        description: "A thrilling walk through the mountains, perfect for adventure seekers.",
        rating: 4.8,
        guideName: "John Doe",
        photo: "https://img.freepik.com/premium-photo/inspiring-travel-adventure-mountain-exploration_985067-1306.jpg",
        pricePerPerson: 50.0
    )).environmentObject(SessionManager())
}
