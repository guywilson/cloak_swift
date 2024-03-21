//
//  Command.swift
//  Cloak
//
//  Created by Guy Wilson on 17/03/2024.
//

import Foundation
import SwiftUI
import PNG

struct MenuHandler {

    func loadImageHandler() -> (NSImage, ImageData) {
        let panel = NSOpenPanel()
        panel.allowsMultipleSelection = false
        panel.canChooseDirectories = false
        panel.title = "Choose an image"
        
        if panel.runModal() == .OK {
            let imageFile = panel.url?.path() ?? "<none>"
            
            return loadImage(filePath: imageFile)
        }
        
        return (NSImage(), ImageData(data: [], size: (0, 0)))
    }

    func saveImageHandler(data: ImageData) -> NSImage {
        let panel = NSSavePanel()
        panel.title = "Save image as"
        
        if panel.runModal() == .OK {
            let imageFile = panel.url?.path() ?? "<none>"
            
            saveImageAs(filePath: imageFile, data: data)
            
            return loadImageOnly(filePath: imageFile)
        }
        
        return NSImage()
    }
}
