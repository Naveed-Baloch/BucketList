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
    @State private var viewModal = ViewModal()
    
    let startPosition = MapCameraPosition.region(
        MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 56, longitude: -3),
            span: MKCoordinateSpan(latitudeDelta: 10, longitudeDelta: 10)
        )
    )
    
    var body: some View {
        MapReader { proxy in
            Map(initialPosition: startPosition) {
                ForEach(viewModal.locations) { location in
                    Annotation(location.name, coordinate: location.coordinate) {
                        Image(systemName: "star.circle")
                            .resizable()
                            .foregroundStyle(.red)
                            .frame(width: 30, height: 30)
                            .background(.white)
                            .clipShape(.circle)
                            .onLongPressGesture {
                                viewModal.selectedPlace = location
                            }
                    }
                }
            }
            .mapStyle(.hybrid)
            .onTapGesture { position in
                if let coordinate = proxy.convert(position, from: .local) {
                    viewModal.addLocation(at: coordinate)
                }
            }
            .sheet(item: $viewModal.selectedPlace) { place in
                LocationEditView(location: place) { newLocation in
                    viewModal.update(location: newLocation)
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
