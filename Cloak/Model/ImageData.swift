//
//  ImageData.swift
//  Cloak
//
//  Created by Guy Wilson on 18/03/2024.
//

import Foundation
import PNG

struct ImageData {
    var data: [PNG.RGBA<UInt8>]
    var size: (x: Int, y: Int)
}
