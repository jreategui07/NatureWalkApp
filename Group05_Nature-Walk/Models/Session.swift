//
//  Session.swift
//  Group05_Nature-Walk
//
//  Created by Jonathan Reátegui on 2024-10-09.
//

import Foundation
import UIKit

class Session: Identifiable, Codable {
    var id = UUID()
    var name: String
    var description: String
    var rating: Float
    var guideName: String
    var photo: String
    var pricePerPerson: Double
    var isFavorite: Bool = false
    
    init(name: String, description: String, rating: Float, guideName: String, photo: String, pricePerPerson: Double) {
        self.name = name
        self.description = description
        self.rating = rating
        self.guideName = guideName
        self.photo = photo
        self.pricePerPerson = pricePerPerson
    }
    
    func toggleFavorite() {
        isFavorite.toggle()
    }
    
    func share() {
        // TODO: logic to share content of the session
    }
}
