//
//  Command.swift
//  Cloak
//
//  Created by Guy Wilson on 17/03/2024.
//

import Foundation
import SwiftUI
import PNG
import UniformTypeIdentifiers

struct MenuHandler {

    func loadImageHandler() -> CloakableImage {
        let panel = NSOpenPanel()
        panel.allowedContentTypes = [UTType.png]
        panel.allowsMultipleSelection = false
        panel.canChooseDirectories = false
        panel.title = "Choose an image"
        
        if panel.runModal() == .OK {
            let imageFile = panel.url?.path() ?? "<none>"
            
            return loadImage(filePath: imageFile)
        }
        
        return CloakableImage(name: "", image: NSImage(), imageData: ImageData(data: [], size: (0, 0)))
    }

    func saveImageHandler(data: ImageData) -> NSImage {
        let panel = NSSavePanel()
        panel.allowedContentTypes = [UTType.png]
        panel.title = "Save image as"
        
        if panel.runModal() == .OK {
            let imageFile = panel.url?.path() ?? "<none>"
            
            saveImageAs(image: CloakableImage(name: imageFile, image: NSImage(), imageData: data))
            
            return loadImageOnly(filePath: imageFile)
        }
        
        return NSImage()
    }

    func loadFileHandler() -> [UInt8] {
        let panel = NSOpenPanel()
        panel.allowsMultipleSelection = false
        panel.canChooseDirectories = false
        panel.title = "Choose a file"
        
        if panel.runModal() == .OK {
            let file = panel.url?.path() ?? "<none>"
            
            return loadFile(path: file)!
        }
        
        return []
    }

    func saveFileHandler(data: [UInt8]) {
        let panel = NSSavePanel()
        panel.allowedContentTypes = [UTType.png]
        panel.title = "Save file as"
        
        if panel.runModal() == .OK {
            let file = panel.url?.path() ?? "<none>"
            
            saveFileAs(path: file, data: data)
        }
    }
}
