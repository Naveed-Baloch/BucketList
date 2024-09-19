//
//  ContentView.swift
//  BucketList
//
//  Created by Naveed on 19/09/2024.
//

import SwiftUI
import MapKit


struct ContentView: View {
    var body: some View {
        Map()
            .mapStyle(.imagery)
    }
}

#Preview {
    ContentView()
}
