//
//  ContentView.swift
//  BucketList
//
//  Created by Naveed on 19/09/2024.
//

import SwiftUI
import MapKit
import LocalAuthentication

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
    
    @State private var isUnlocked = false
    
    var body: some View {
        VStack {
            
            VStack {
                if isUnlocked {
                    Text("Unlocked")
                } else {
                    Text("Locked")
                }
                
                Button(action: authenticate, label: {
                    Text("Login")
                })
            }
            
            MapReader { proxy in
                Map(
                    position: $position,
                    interactionModes: [.zoom, .rotate, .pan]
                ) {
                    ForEach(locations) { location in
                        Annotation(location.name, coordinate: location.coordinate) {
                            Text(location.name)
                                .font(.headline)
                                .padding()
                                .background(.blue)
                                .foregroundStyle(.white)
                                .clipShape(.capsule)
                        }
                        .annotationTitles(.hidden)
                    }
                }
                .mapStyle(.imagery)
                .onMapCameraChange(frequency: .continuous) { context in
                    print(context.region)
                }
                .onTapGesture { position in
                    print(position)
                    if let coordinate = proxy.convert(position, from: .local) {
                        print(coordinate)
                    }
                    
                }
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
    
    func authenticate() {
        let context = LAContext()
        var error: NSError?

        // check whether biometric authentication is possible
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            // it's possible, so go ahead and use it
            let reason = "We need to unlock your data."
            
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, authenticationError in
                // authentication has now completed
                if success {
                    isUnlocked = true
                } else {
                    // there was a problem
                }
            }
        } else {
            // no biometrics
        }
    }
}

#Preview {
    ContentView()
}
