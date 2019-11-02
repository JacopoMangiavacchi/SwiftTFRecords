//
//  Builder.swift
//
//
//  Created by Jacopo Mangiavacchi on 11/1/19.
//

import Foundation

struct Builder {
    var records: [Record]

    var data: Data {
        // TODO SAVE TO TF RECORDS
        Data()
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
    
    func save(to file: String) {
        
    }
}
