//
//  TFRecords.swift
//
//
//  Created by Jacopo Mangiavacchi on 11/3/19.
//

import Foundation
import CryptoSwift

public struct TFRecords {
    public var records: [Record]

    public var data: Data {
        var data = Data()
        
        for record in records {
            if let recordData = record.data, recordData.count > 0 {
                var length64 = UInt64(recordData.count)
                let length64Array = intToArray(length64)
                var lengthMaskedCRC = maskCrc(Checksum.crc32c(length64Array))
                var dataMaskedCRC = maskCrc(Checksum.crc32c([UInt8](recordData)))

                data.append(Data(bytes: &length64, count: MemoryLayout.size(ofValue: length64)))
                data.append(Data(bytes: &lengthMaskedCRC, count: MemoryLayout.size(ofValue: lengthMaskedCRC)))
                data.append(recordData)
                data.append(Data(bytes: &dataMaskedCRC, count: MemoryLayout.size(ofValue: dataMaskedCRC)))
            }
        }
        
        return data
    }
    
    public init() {
        records = [Record]()
    }

    public init(withRecords records: [Record]) {
        self.records = records
    }
    
    public init(withData data: Data) {
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
            
            let length64Array = intToArray(length64)
            let lengthMaskedCRCExpected = maskCrc(Checksum.crc32c(length64Array))

            guard lengthMaskedCRC == lengthMaskedCRCExpected else { break }

            let recordData = data.subdata(in: pos..<pos+Int(length64))
            pos += Int(length64)
            
            let dataMaskedCRCExpected = data.subdata(in: pos..<pos+4).withUnsafeBytes {
                $0.load(as: UInt32.self)
            }
            pos += 4
            
            let dataMaskedCRC = maskCrc(Checksum.crc32c([UInt8](recordData)))
            
            guard dataMaskedCRC == dataMaskedCRCExpected else { break }
            
            records.append(Record(withData: recordData))
        }
        
        self.records = records
    }

    public mutating func add(_ record: Record) {
        records.append(record)
    }
}
