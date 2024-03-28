//
//  FileData.swift
//  Cloak
//
//  Created by Guy Wilson on 18/03/2024.
//

import Foundation

struct CloakedFile {
    var name: String
    var data: [UInt8]
    
    var length: UInt {
        return UInt(data.count)
    }
    
    func getBitMask(bitCount: Int) -> UInt8 {
        var bm: UInt8 = 0
        
        switch bitCount {
            case 1:
                bm = 0b00000001
            
            case 2:
                bm = 0b00000011
            
            case 4:
                bm = 0b00001111
            
            default:
                bm = 0b00000001
        }
        
        return bm
    }
}

class BitStream {
    private var _data: [UInt8]
    private var _bitMask: UInt8
    
    var dataLength: Int {
        return _data.count
    }

    init(file: CloakedFile, bitCount: Int) {
        self._data = file.data
        self._bitMask = file.getBitMask(bitCount: bitCount)
    }
    
    func getBitMask() -> UInt8 {
        return _bitMask
    }
    
    func getByteAt(_ index: Int) -> UInt8? {
        return index < (_data.count) ? _data[index] : nil
    }
}

extension BitStream: Sequence {
    func makeIterator() -> BitStreamIterator {
        return BitStreamIterator(self)
    }
}

class BitStreamIterator: IteratorProtocol {
    private var _bitStream: BitStream
    private var _byteIndex: Int
    private var _bitIndex: Int
    private var _currentByte: UInt8
    
    typealias Element = UInt8
    
    init(_ bitStream: BitStream) {
        _byteIndex = 0
        _bitIndex = 0
        _bitStream = bitStream
        _currentByte = 0
    }
    
    func hasNext() -> Bool {
        _currentByte = _bitStream.getByteAt(_byteIndex) ?? 0
        return _byteIndex < _bitStream.dataLength
    }
    
    func next() -> UInt8? {
        let bitMask: UInt8 = _bitStream.getBitMask()
        
        let bits: UInt8 = _currentByte & bitMask
        
        switch bitMask {
            case 0b00000001:
                _bitIndex += 1
                _currentByte >>= 1

            case 0b00000011:
                _bitIndex += 2
                _currentByte >>= 2

            case 0b00001111:
                _bitIndex += 4
                _currentByte >>= 4

            default:
                _bitIndex += 1
                _currentByte >>= 1
        }
        
        if _bitIndex == 8 {
            _byteIndex += 1
            _bitIndex = 0
        }
        
        return bits
    }
}
