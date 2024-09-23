//
//  Location.swift
//  BucketList
//
//  Created by Naveed on 23/09/2024.
//

import Foundation
import MapKit

struct Location: Identifiable, Codable, Equatable {
    var id: UUID
    var name: String
    var description: String
    var latitude: Double
    var longitude: Double
    
    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    
    static func ==(lhs: Location, rhs: Location) -> Bool {
        lhs.id == rhs.id
    }
    
    #if DEBUG
    static let example = Location(
        id: UUID(), name: "Buckingham Palace", description: "Lit by over 40,000 lightbulbs.",
        latitude: 51.501, longitude: -0.141
    )
    #endif
}
