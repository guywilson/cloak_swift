//
//  ModelData.swift
//  Cloak
//
//  Created by Guy Wilson on 16/03/2024.
//

import Foundation
import AppKit
import PNG

@Observable
class ModelData {
    var sourceImage: NSImage = NSImage()
    var sourceImageData: ImageData = ImageData(data: [], size: (50, 50))
}
