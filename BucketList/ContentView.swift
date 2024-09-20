//
//  ContentView.swift
//  BucketList
//
//  Created by Naveed on 19/09/2024.
//

import SwiftUI
import MapKit

struct Location: Identifiable {
    let id = UUID()
    var name: String
    var coordinate: CLLocationCoordinate2D
}

struct ContentView: View {
    let locations = [
        Location(
            name: "Buckingham Palace",
            coordinate: CLLocationCoordinate2D(latitude: 51.501, longitude: -0.141)
        ),
        Location(
            name: "Tower of London",
            coordinate: CLLocationCoordinate2D(latitude: 51.508, longitude: -0.076)
        )
    ]
    
    let initialPostion = MapCameraPosition.region(
        MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 51.507222, longitude: -0.1275),
            span: MKCoordinateSpan(latitudeDelta: 1, longitudeDelta: 1)
        )
    )
    
    @State private var position = MapCameraPosition.region(
        MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 51.507222, longitude: -0.1275),
            span: MKCoordinateSpan(latitudeDelta: 1, longitudeDelta: 1)
        )
    )
    
    var body: some View {
        VStack {
            Map(
                position: $position,
                interactionModes: [.zoom, .rotate, .pan]
            ) {
                ForEach(locations) { location in
                    Marker(location.name, coordinate: location.coordinate)
                }
            }
            .mapStyle(.imagery)
            .onMapCameraChange(frequency: .continuous) { context in
                print(context.region)
            }
            
            HStack(spacing: 50) {
                Button("Paris") {
                    position = MapCameraPosition.region(
                        MKCoordinateRegion(
                            center: CLLocationCoordinate2D(latitude: 48.8566, longitude: 2.3522),
                            span: MKCoordinateSpan(latitudeDelta: 1, longitudeDelta: 1)
                        )
                    )
                }
                
                Button("Tokyo") {
                    position = MapCameraPosition.region(
                        MKCoordinateRegion(
                            center: CLLocationCoordinate2D(latitude: 35.6897, longitude: 139.6922),
                            span: MKCoordinateSpan(latitudeDelta: 1, longitudeDelta: 1)
                        )
                    )
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
