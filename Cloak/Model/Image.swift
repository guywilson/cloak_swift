//
//  ImageData.swift
//  Cloak
//
//  Created by Guy Wilson on 18/03/2024.
//

import Foundation
import PNG
import AppKit

struct ImageData {
    var data: [PNG.RGBA<UInt8>]
    var size: (x: Int, y: Int)
}

struct CloakableImage {
    var name:       String
    var image:      NSImage
    var imageData:  ImageData
    
    func getCapacity(_ level: CloakSecurityLevel) -> UInt {
        return UInt(((imageData.data.count * 3) / (8 / level.rawValue)))
    }
}

func createImageFromRawData(imageData: inout [PNG.RGBA<UInt8>], imageSize: (x: Int, y: Int)) -> NSImage {
    let ctx: CGContext = CGContext(
        data: &imageData,
        width: imageSize.x,
        height: imageSize.y,
        bitsPerComponent: 8,
        bytesPerRow: imageSize.x * 4,
        space: CGColorSpace(name: CGColorSpace.sRGB)!,
        bitmapInfo: CGBitmapInfo.byteOrderDefault.rawValue +
            CGImageAlphaInfo.premultipliedLast.rawValue
        )!

    let cgImage: CGImage = ctx.makeImage()!
    
    return NSImage(cgImage: cgImage, size: NSSize(width: imageSize.x, height: imageSize.y))
}
