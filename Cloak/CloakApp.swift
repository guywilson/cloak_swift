//
//  CloakApp.swift
//  Cloak
//
//  Created by Guy Wilson on 16/03/2024.
//

import SwiftUI

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
                }
                Button("Extract file from image...") {
                    MenuHandler().saveFileHandler(data: modelData.sourceFile.data)
                }
            }
        }
    }
}
