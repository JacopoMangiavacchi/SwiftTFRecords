//
//  Reader.swift
//  
//
//  Created by Jacopo Mangiavacchi on 11/1/19.
//

import Foundation
import CryptoSwift

public struct Reader {
    let records: [Record]

    init(withData data: Data) {
        var records = [Record]()
        var pos = 0
        while pos < data.count {
            let length64 = data.subdata(in: pos..<pos+8).withUnsafeBytes {
                $0.load(as: UInt64.self)
            }
            pos += 8
            
            let lengthMaskedCRC = data.subdata(in: pos..<pos+4).withUnsafeBytes {
                $0.load(as: UInt32.self)
            }
            pos += 4
            
            let length32 = UInt32(length64)
            let length32Array = intToArray(length32)
            let lengthMaskedCRCExpected = maskCrc(Checksum.crc32c(length32Array))

            if lengthMaskedCRC == lengthMaskedCRCExpected {
                let recordData = data.subdata(in: pos..<pos+Int(length64))
                pos += Int(length64)
                
                let dataMaskedCRCExpected = data.subdata(in: pos..<pos+4).withUnsafeBytes {
                    $0.load(as: UInt32.self)
                }
                pos += 4
                
                let dataMaskedCRC = dataMaskedCRCExpected // TODO !!!
                
                if dataMaskedCRC == dataMaskedCRCExpected {
                    records.append(Record(withData: recordData))
                }
                else {
                    print(" --> dataMaskedCRC != dataMaskedCRCExpected")
                    break
                }
            }
            else {
                print(" --> lengthMaskedCRC != lengthMaskedCRCExpected")
                break
            }
        }
        
        self.records = records
    }
    
    // TODO ADD SUBSCRIPT

    // TODO ADD SUBSCRIPT WITH RANGE
}
