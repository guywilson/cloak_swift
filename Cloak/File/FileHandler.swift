//
//  FileHandler.swift
//  Cloak
//
//  Created by Guy Wilson on 18/03/2024.
//

import Foundation

func loadFile(path: String) throws -> [UInt8]? {
    let url: URL = URL(filePath: path)
    let fileHandle: FileHandle? = try FileHandle(forReadingFrom: url)
    
    if fileHandle == nil {
        fatalError("Failed to open file: \(path)")
    }
    
    do {
        let rawData: Data? = try fileHandle?.readToEnd()
        return [UInt8](rawData!)
    }
    catch {
        fatalError("Failed to read from file \(path)")
    }
}

func saveFileAs(path: String, data: [UInt8]) {
    let fileHandle: FileHandle? = FileHandle(forWritingAtPath: path)
    
    let rawData: Data = Data(data)
    
    fileHandle?.write(rawData)
}
