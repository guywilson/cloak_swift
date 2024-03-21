//
//  ContentView.swift
//  Cloak
//
//  Created by Guy Wilson on 16/03/2024.
//

import SwiftUI

struct ContentView: View {
    @Environment(ModelData.self) var modelData
    @State private var isPopOverShowing: Bool = false
    @State private var securityLevel: CloakSecurityLevel = CloakSecurityLevel.SECURITY_HIGH
    
    var body: some View {
        let capacity: UInt = modelData.sourceImage.getCapacity(modelData.securityLevel)
        
        VStack {
            HStack {
                GroupBox() {
                    Text("Image: \(modelData.sourceImage.name)")
                        .font(.caption)
                        .frame(width: 400, height: 20, alignment: .leading)
                }
                .padding(.leading)
                
                GroupBox {
                    Text("Capacity: \(capacity)bytes")
                        .font(.caption)
                        .frame(width: 180, height: 20, alignment: .leading)
                }

                Picker("", selection: $securityLevel) {
                        Text("1-bit").tag(CloakSecurityLevel.SECURITY_HIGH)
                        Text("2-bit").tag(CloakSecurityLevel.SECURITY_MEDIUM)
                        Text("4-bit").tag(CloakSecurityLevel.SECURITY_LOW)
                }
                .onChange(of: securityLevel, {modelData.securityLevel = securityLevel})
                .tint(.white)
                .buttonStyle(PlainButtonStyle())
                .frame(width: 120, height: 28)
                .background(RoundedRectangle(cornerRadius: 6).fill(Color.blue))
                    
                Spacer()
            }
            GroupBox {
                PNGView(image: modelData.sourceImage.image)
                    .frame(minWidth: 700, minHeight: 400)
            }
            .padding(.leading)
            .padding(.trailing)
            
            Spacer()
        }
    }
}

#Preview {
    ContentView()
        .environment(ModelData())
}
