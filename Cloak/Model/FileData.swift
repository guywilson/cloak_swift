//
//  FileData.swift
//  Cloak
//
//  Created by Guy Wilson on 18/03/2024.
//

import Foundation

struct FileData {
    var data:       [UInt8]
    
    var dataLength: Int {
        return data.count
    }
}
