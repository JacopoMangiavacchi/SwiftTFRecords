//
//  Helper.swift
//  
//
//  Created by Jacopo Mangiavacchi on 11/3/19.
//

import Foundation

func maskCrc(_ crc: UInt32) -> UInt32 {
    UInt32(Int(Int((crc >> 15) | (crc << 17)) + 0xa282ead8) % Int(pow(2.0, 32.0)))
}

func intToArray(_ n: UInt64) -> [UInt8] {
    let data = withUnsafeBytes(of: n) { Data($0) }
    return [UInt8](data)
}
