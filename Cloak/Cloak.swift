//
//  Cloak.swift
//  Cloak
//
//  Created by Guy Wilson on 21/03/2024.
//

import Foundation
import PNG

enum CloakSecurityLevel: Int {
    case SECURITY_HIGH = 1
    case SECURITY_MEDIUM = 2
    case SECURITY_LOW = 4
}

struct Cloak {
    func flatternImage(imageData: ImageData) -> [UInt8] {
        var data: [UInt8] = Array(repeating: 0, count: (imageData.size.x * imageData.size.y))

        let numChannels: Int = 3

        for pixel in imageData.data {
            for channelIndex in 0..<numChannels {
                if channelIndex == 0 {
                    data.append(pixel.r)
                }
                else if channelIndex == 1 {
                    data.append(pixel.g)
                }
                else if channelIndex == 2 {
                    data.append(pixel.b)
                }
            }
        }
        
        saveFileAs(path: "/Users/guy/temp.dat", data: data)
        
        return data
    }
    
    func cloak(data: inout [PNG.RGBA<UInt8>], file: CloakedFile, quality: CloakSecurityLevel = CloakSecurityLevel.SECURITY_HIGH) {
        
        let bitStream: BitStream = BitStream(file: file, bitCount: quality.rawValue)
        let it: BitStreamIterator = bitStream.makeIterator()
        let numChannels: Int = 3
        
        var pixelIndex: Int = 0
        
        for i in data.indices {
            for channelIndex in 0..<numChannels {
                if it.hasNext() {
                    let bits: UInt8 = it.next()!
                    
                    if channelIndex == 0 {
                        data[i].r = (data[i].r & ~bitStream.getBitMask()) | bits
                    }
                    else if channelIndex == 1 {
                        data[i].g = (data[i].g & ~bitStream.getBitMask()) | bits
                    }
                    else if channelIndex == 2 {
                        data[i].b = (data[i].b & ~bitStream.getBitMask()) | bits
                    }
                }
            }
                        
            pixelIndex += 1
        }
    }
    
    func extract(name: String, image: CloakableImage, quality: CloakSecurityLevel = CloakSecurityLevel.SECURITY_HIGH) -> CloakedFile {
        var rawData: [UInt8] = []
        
        let file: CloakedFile = CloakedFile(name: name, data: [])
        var pixelIndex: Int = 0
        var dataIndex: Int = 0
        var bitCounter: Int = 0
        var bits: UInt8 = 0

        let numChannels: Int = 3
        let numImageBytes: Int = 8 / quality.rawValue

        for pixel in image.imageData.data {
            for channelIndex in 0..<numChannels {
                for _ in 0..<numImageBytes {
                    if channelIndex == 0 {
                        bits = pixel.r & file.getBitMask(bitCount: quality.rawValue)
                        rawData[dataIndex] += bits << bitCounter
                    }
                    else if channelIndex == 1 {
                        bits = pixel.r & file.getBitMask(bitCount: quality.rawValue)
                        rawData[dataIndex] += bits << bitCounter
                    }
                    else if channelIndex == 2 {
                        bits = pixel.r & file.getBitMask(bitCount: quality.rawValue)
                        rawData[dataIndex] += bits << bitCounter
                    }

                    bitCounter += quality.rawValue
                    
                    if bitCounter == 8 {
                        bitCounter = 0
                    }
                }
            }
             
            dataIndex += 1
            pixelIndex += 1
        }

        return CloakedFile(name: name, data: rawData)
    }
}
