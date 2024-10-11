//
//  Session.swift
//  Group05_Nature-Walk
//
//  Created by Jonathan Reátegui on 2024-10-09.
//

import Foundation

class Session: Identifiable, Codable {
    var id = UUID()
    var name: String
    var description: String
    var rating: Float
    var guideName: String
    var photos: [String]
    var pricePerPerson: Double
    var isFavorite: Bool = false
    
    init(name: String, description: String, rating: Float, guideName: String, photos: [String], pricePerPerson: Double) {
        self.name = name
        self.description = description
        self.rating = rating
        self.guideName = guideName
        self.photos = photos
        self.pricePerPerson = pricePerPerson
    }
}
