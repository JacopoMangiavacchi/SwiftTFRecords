//
//  TFRecords.swift
//
//
//  Created by Jacopo Mangiavacchi on 11/3/19.
//

import Foundation
import CryptoSwift

public struct TFRecords {
    var records: [Record]

    var data: Data {
        var data = Data()
        
        for record in records {
            if let recordData = record.data, recordData.count > 0 {
                let length32 = UInt32(recordData.count)
                var length64 = UInt64(recordData.count)
                let length32Array = intToArray(length32)
                var lengthMaskedCRC = maskCrc(Checksum.crc32c(length32Array))
                var dataMaskedCRC = maskCrc(Checksum.crc32c([UInt8](recordData)))

                data.append(Data(bytes: &length64, count: MemoryLayout.size(ofValue: length64)))
                data.append(Data(bytes: &lengthMaskedCRC, count: MemoryLayout.size(ofValue: lengthMaskedCRC)))
                data.append(recordData)
                data.append(Data(bytes: &dataMaskedCRC, count: MemoryLayout.size(ofValue: dataMaskedCRC)))
            }
        }
        
        return data
    }
    
    init() {
        records = [Record]()
    }

    init(withRecords records: [Record]) {
        self.records = records
    }
    
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
                    break
                }
            }
            else {
                break
            }
        }
        
        self.records = records
    }

    mutating func add(_ record: Record) {
        records.append(record)
    }
}
