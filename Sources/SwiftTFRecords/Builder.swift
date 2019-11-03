//
//  Builder.swift
//
//
//  Created by Jacopo Mangiavacchi on 11/1/19.
//

import Foundation

public struct Builder {
    var records: [Record]

    var data: Data {
        var data = Data()
        
        for record in records {
            if let recordData = record.data, recordData.count > 0 {
                var length32 = Int32(recordData.count)
                var length64 = Int64(recordData.count)

                let length32Buffer = Data(bytes: &length32, count: MemoryLayout.size(ofValue: length32))
                let length64Buffer = Data(bytes: &length64, count: MemoryLayout.size(ofValue: length64))

                var lengthMaskedCRC = Int32(3) //Int32(maskCrc(crc32c(length32Buffer)))
                var dataMaskedCRC = Int32(3) //Int32(maskCrc(crc32c(recordData)))

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
