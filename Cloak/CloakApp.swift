//
//  CloakApp.swift
//  Cloak
//
//  Created by Guy Wilson on 16/03/2024.
//

import SwiftUI
import PNG

@main
struct CloakApp: App {
    @State private var modelData: ModelData = ModelData()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(modelData)
        }
        .commands {
            CommandMenu("Tools") {
                Button("Encryption...") {
                    
                }
            }
            CommandGroup(after: .newItem) {
                Divider()
                
                Button("Open image...") {
                    modelData.sourceImage = MenuHandler().loadImageHandler()
                }
                
                Button("Save image as...") {
                    modelData.sourceImage.image = MenuHandler().saveImageHandler(data: modelData.sourceImage.imageData)
                }

                Divider()

                Button("Add file to image...") {
                    modelData.sourceFile.data = MenuHandler().loadFileHandler()
                    
                    let c: Cloak = Cloak()

                    if modelData.sourceImage.getCapacity(modelData.securityLevel) < modelData.sourceFile.length {
                        fatalError("File \(modelData.sourceFile.name) is too large to fit in image \(modelData.sourceImage.name)")
                    }

                    c.cloak(
                        data: &modelData.sourceImage.imageData.data,
                        file: modelData.sourceFile,
                        quality: modelData.securityLevel)
                    
                    modelData.sourceImage.image =
                        createImageFromRawData(
                            imageData: &modelData.sourceImage.imageData.data,
                            imageSize: modelData.sourceImage.imageData.size)
                }
                
                Button("Extract file from image...") {
                    MenuHandler().saveFileHandler(data: modelData.sourceFile.data)
                }
            }
        }
    }
}
