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
