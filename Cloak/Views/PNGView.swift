//
//  PNGView.swift
//  Cloak
//
//  Created by Guy Wilson on 18/03/2024.
//

import SwiftUI

struct PNGView: View {
    var image: NSImage

    var body: some View {
        VStack {
            Image(nsImage: image)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
        }
        .padding(EdgeInsets())
    }
}

#Preview {
    let image: NSImage = NSImage()
    return PNGView(image: image)
}
