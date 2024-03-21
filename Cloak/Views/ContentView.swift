//
//  ContentView.swift
//  Cloak
//
//  Created by Guy Wilson on 16/03/2024.
//

import SwiftUI

struct ContentView: View {
    @Environment(ModelData.self) var modelData
    
    var body: some View {
        PNGView(image: modelData.sourceImage)
    }
}

#Preview {
    ContentView()
        .environment(ModelData())
}
