//
//  FileHandler.swift
//  Cloak
//
//  Created by Guy Wilson on 18/03/2024.
//

import Foundation

func loadFile(path: String) -> [UInt8]? {
    let fileHandle: FileHandle? = FileHandle(forReadingAtPath: path)
    
    do {
        let rawData: Data? = try fileHandle?.readToEnd()
        return [UInt8](rawData!)
    }
    catch {
        return nil
    }
}

func saveFileAs(path: String, data: [UInt8]) {
    let fileHandle: FileHandle? = FileHandle(forWritingAtPath: path)
    
    let rawData: Data = Data(data)
    
    fileHandle?.write(rawData)
}
