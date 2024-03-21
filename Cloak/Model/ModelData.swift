//
//  ModelData.swift
//  Cloak
//
//  Created by Guy Wilson on 16/03/2024.
//

import Foundation
import AppKit
import PNG

enum CloakSecurityLevel: Int {
    case SECURITY_HIGH = 1
    case SECURITY_MEDIUM = 2
    case SECURITY_LOW = 4
}

struct CloakableImage {
    var name:       String
    var image:      NSImage
    var imageData:  ImageData
    
    func getCapacity(_ level: CloakSecurityLevel) -> UInt {
        return UInt((imageData.data.count / (8 / level.rawValue)))
    }
}

struct CloakedFile {
    var name: String
    var data: [UInt8]
    
    var length: Int {
        return data.count
    }
}

@Observable
class ModelData {
    var sourceImage: CloakableImage = 
                        CloakableImage(
                            name: "",
                            image: NSImage(),
                            imageData: ImageData(data: [], size: (0, 0)))
    
    var sourceFile: CloakedFile =
                        CloakedFile(
                            name: "",
                            data: [])
    
    var securityLevel: CloakSecurityLevel = CloakSecurityLevel.SECURITY_HIGH
}
