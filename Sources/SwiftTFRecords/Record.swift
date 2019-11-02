//
//  Record.swift
//  
//
//  Created by Jacopo Mangiavacchi on 11/1/19.
//

import Foundation

public struct Record {
    var context: [String : Feature]

    var data: Data? {
        var example = Tfrecords_Example()

        for (name, feature) in context {
            var tfFeature = Tfrecords_Feature()
            
            switch feature {
            case let .Bytes(value):
                var list = Tfrecords_BytesList()
                list.value = [value]
                tfFeature.bytesList = list

            case let .Float(value):
                var list = Tfrecords_FloatList()
                list.value = [value]
                tfFeature.floatList = list

            case let .Int(value):
                var list = Tfrecords_Int64List()
                list.value = [Int64(value)]
                tfFeature.int64List = list
            }
            
            example.features.feature[name] = tfFeature
        }
        
        return try? example.serializedData()
    }

    init() {
        self.context = [String : Feature]()
    }

    init(withData data: Data) {
        self.context = [String : Feature]()

        // TODO READ TF RECORD FROM DATA
    }
    
    mutating func set(name: String, feature: Feature?) {
        context[name] = feature
    }

    func get(name: String) -> Feature? {
        return context[name]
    }
}
