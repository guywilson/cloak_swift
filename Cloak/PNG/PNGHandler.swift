//
//  PNGHandler.swift
//  Cloak
//
//  Created by Guy Wilson on 17/03/2024.
//

import Foundation
import AppKit
import PNG

func decode(path: String) throws -> ImageData {
    guard let image: PNG.Image = try.decompress(path: path)
    else {
        fatalError("Failed to open '\(path).png'")
    }
    
    let rgba: [PNG.RGBA<UInt8>] = image.unpack(as: PNG.RGBA<UInt8>.self)
    let size: (Int, Int) = image.size
    
    return ImageData(data: rgba, size: size)
}

func encode(path: String, data: inout [PNG.RGBA<UInt8>], size: (x: Int, y: Int), level: Int = 9) throws {
    let image: PNG.Image =
        .init(packing: data, size: size, layout: .init(format: .rgb8(palette: [], fill: nil, key: nil)))
    
    try image.compress(path: path, level: level)
}

func loadImage(filePath: String) -> CloakableImage {
    var imageData: ImageData
    
    let image: NSImage = loadImageOnly(filePath: filePath)

    do {
        imageData = try decode(path: filePath)
    }
    catch {
        fatalError("Failed to decode PNG image \(filePath)")
    }

    return CloakableImage(name: filePath, image: image, imageData: imageData)
}

func loadImageOnly(filePath: String) -> NSImage {
    let url: URL = URL(fileURLWithPath: filePath)
    let image: NSImage = NSImage(contentsOf: url)!

    return image
}

func saveImageAs(image: CloakableImage) {
    var data: [PNG.RGBA<UInt8>] = image.imageData.data
    
    do {
        try encode(path: image.name, data: &data, size: image.imageData.size)
    }
    catch {
        fatalError("Failed to encode PNG image \(image.name)")
    }
}
