//
//  Builder.swift
//
//
//  Created by Jacopo Mangiavacchi on 11/1/19.
//

import Foundation
import CryptoSwift

public struct Builder {
    private static func intToArray(_ n: Int32) -> [UInt8] {
        return String(n).unicodeScalars.map{UInt8($0.value)}
    }

    var records: [Record]

    var data: Data {
        var data = Data()
        
        for record in records {
            if let recordData = record.data, recordData.count > 0 {
                var length64 = Int64(recordData.count)
                let length64Buffer = Data(bytes: &length64, count: MemoryLayout.size(ofValue: length64))

                let length32 = Int32(recordData.count)
                let length32Array = Builder.intToArray(length32)
                
                var lengthMaskedCRC = Checksum.crc32c(length32Array) //Int32(maskCrc(crc32c(length32Buffer)))
                var dataMaskedCRC = Checksum.crc32c(length32Array) //Int32(maskCrc(crc32c(recordData)))

                data.append(length64Buffer)
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
