//
//  ContentView.swift
//  BucketList
//
//  Created by Naveed on 19/09/2024.
//

import SwiftUI
import MapKit


struct ContentView: View {
    let initialPostion = MapCameraPosition.region(
        MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 51.507222, longitude: -0.1275),
            span: MKCoordinateSpan(latitudeDelta: 1, longitudeDelta: 1)
        )
    )
    
    var body: some View {
        Map(initialPosition: initialPostion,
            interactionModes: [.zoom, .rotate, .pan])
            .mapStyle(.imagery)
    }
}

#Preview {
    ContentView()
}
