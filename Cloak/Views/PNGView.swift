//
//  PNGView.swift
//  Cloak
//
//  Created by Guy Wilson on 18/03/2024.
//

import SwiftUI

struct PNGView: View {
    @Environment(ModelData.self) var modelData
    var image: NSImage

    var body: some View {
        @Bindable var modelData = modelData
        
        VStack {
            Image(nsImage: image)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
        }
        .padding(EdgeInsets())
    }
}

#Preview {
    let modelData = ModelData()
    return PNGView(image: modelData.sourceImage.image)
}
