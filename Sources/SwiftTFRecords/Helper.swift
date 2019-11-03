//
//  Helper.swift
//  
//
//  Created by Jacopo Mangiavacchi on 11/3/19.
//

import Foundation

func maskCrc(_ crc: UInt32) -> UInt32 {
    ((crc >> 15) | (crc << 17)) + 0xa282ead8
}

func intToArray(_ n: UInt32) -> [UInt8] {
    return String(n).unicodeScalars.map{UInt8($0.value)}
}

