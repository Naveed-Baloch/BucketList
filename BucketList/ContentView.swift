//
//  ContentView.swift
//  BucketList
//
//  Created by Naveed on 19/09/2024.
//

import SwiftUI
import MapKit
import LocalAuthentication


struct ContentView: View {
    @State private var locations = [Location]()
    
    @State private var selectedLocation: Location?
    
    let startPosition = MapCameraPosition.region(
        MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 56, longitude: -3),
            span: MKCoordinateSpan(latitudeDelta: 10, longitudeDelta: 10)
        )
    )
    
    var body: some View {
        MapReader { proxy in
            Map(initialPosition: startPosition) {
                ForEach(locations) { location in
                    Annotation(location.name, coordinate: location.coordinate) {
                        Image(systemName: "star.circle")
                            .resizable()
                            .foregroundStyle(.red)
                            .frame(width: 30, height: 30)
                            .background(.white)
                            .clipShape(.circle)
                            .onLongPressGesture {
                                selectedLocation = location
                            }
                    }
                }
            }
            .mapStyle(.hybrid)
            .onTapGesture { position in
                if let coordinate = proxy.convert(position, from: .local) {
                    let newLocation = Location(
                        id: UUID(), name: "New location", description: "",
                        latitude: coordinate.latitude, longitude: coordinate.longitude
                    )
                    locations.append(newLocation)
                }
            }
            .sheet(item: $selectedLocation) { place in
                LocationEditView(location: place) { newLocation in
                    if let index = locations.firstIndex(of: place) {
                        locations[index] = newLocation
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
