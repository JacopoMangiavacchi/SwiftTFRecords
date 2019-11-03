//
//  Builder.swift
//
//
//  Created by Jacopo Mangiavacchi on 11/1/19.
//

import Foundation
import CryptoSwift

public struct Builder {
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

    mutating func add(_ record: Record) {
        records.append(record)
    }
}
