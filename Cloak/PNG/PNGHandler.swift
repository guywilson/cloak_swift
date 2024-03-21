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

func encode(path: String, data: ImageData, level: Int = 9) throws {
    let image: PNG.Image =
        .init(packing: data.data, size: data.size, layout: .init(format: .rgba8(palette: [], fill: nil)))
    
    try image.compress(path: path, level: level)
}

func loadImage(filePath: String) -> (NSImage, ImageData) {
    var imageData: ImageData
    
    let image: NSImage = loadImageOnly(filePath: filePath)

    do {
        imageData = try decode(path: filePath)
    }
    catch {
        fatalError("Failed to decode PNG image \(filePath)")
    }

    return (image, imageData)
}

func loadImageOnly(filePath: String) -> NSImage {
    let url: URL = URL(fileURLWithPath: filePath)
    let image: NSImage = NSImage(contentsOf: url)!

    return image
}

func saveImageAs(filePath: String, data: ImageData) {
    do {
        try encode(path: filePath, data: data)
    }
    catch {
        fatalError("Failed to encode PNG image \(filePath)")
    }
}
