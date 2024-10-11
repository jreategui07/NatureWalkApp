//
//  SessionManager.swift
//  Group05_Nature-Walk
//
//  Created by Jonathan Reátegui on 2024-10-09.
//

import Foundation

class SessionManager: ObservableObject {
    @Published var allSessions: [Session] = []

    let persistenceManager = PersistenceManager()

    init() {
        allSessions = persistenceManager.getAllSessions()
    }

    func addSession(_ session: Session) {
        allSessions.append(session)
        persistenceManager.saveSession(session)
    }

    func deleteSession(at offsets: IndexSet) {
        offsets.forEach { index in
            let sessionID = allSessions[index].id
            persistenceManager.deleteSession(withID: sessionID)
        }
        allSessions.remove(atOffsets: offsets)
    }

    func updateSession(_ session: Session) {
        if let index = allSessions.firstIndex(where: { $0.id == session.id }) {
            allSessions[index] = session
        }
    }
}
