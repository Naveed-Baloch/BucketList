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
    @State private var viewModel = ViewModel()
    private let mapStyles = MapTheme.allCases
    @State private var selectedMapTheme = MapTheme.standard
    
    let startPosition = MapCameraPosition.region(
        MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 56, longitude: -3),
            span: MKCoordinateSpan(latitudeDelta: 10, longitudeDelta: 10)
        )
    )
    
    var body: some View {
        if viewModel.isUnlocked {
            ZStack {
                MapReader { proxy in
                    Map(initialPosition: startPosition) {
                        ForEach(viewModel.locations) { location in
                            Annotation(location.name, coordinate: location.coordinate) {
                                Image(systemName: "star.circle")
                                    .resizable()
                                    .foregroundStyle(.red)
                                    .frame(width: 30, height: 30)
                                    .background(.white)
                                    .clipShape(.circle)
                                    .onLongPressGesture {
                                        viewModel.selectedPlace = location
                                    }
                            }
                        }
                    }
                    .mapStyle(selectedMapTheme.style)
                    .onTapGesture { position in
                        if let coordinate = proxy.convert(position, from: .local) {
                            viewModel.addLocation(at: coordinate)
                        }
                    }
                    .sheet(item: $viewModel.selectedPlace) { place in
                        LocationEditView(location: place) { newLocation in
                            viewModel.update(location: newLocation)
                        }
                    }
                }
                
                VStack {
                    Spacer()
                    Picker("Map Style", selection: $selectedMapTheme) {
                        ForEach(mapStyles, id: \.self) { style in
                            Text(style.rawValue)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .padding()
                }
            }
        }
        else  {
            Button("Unlock Places", action: viewModel.authenticate)
                .padding()
                .background(.blue)
                .foregroundStyle(.white)
                .clipShape(.capsule)
        }
    }
}

enum MapTheme: String, CaseIterable {
    case hybrid = "Hybrid"
    case imagery = "Imagery"
    case standard = "Standard"
    
    var style: MapStyle {
        switch self {
        case .hybrid:
            return MapStyle.hybrid
        case .imagery:
            return MapStyle.imagery
        case .standard:
            return MapStyle.standard
        }
    }
}


#Preview {
    ContentView()
}
