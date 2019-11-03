//
//  Record.swift
//  
//
//  Created by Jacopo Mangiavacchi on 11/1/19.
//

import Foundation

public struct Record {
    public var context: [String : Feature]

    public var data: Data? {
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

    public init() {
        self.context = [String : Feature]()
    }

    public init(withData data: Data) {
        self.context = [String : Feature]()
        
        guard let example = try? Tfrecords_Example(serializedData: data) else { return }

        for (name, feature) in example.features.feature {
            switch feature.kind {
            case let .bytesList(list):
                if !list.value.isEmpty {
                    context[name] = Feature.Bytes(list.value[0])
                }
            case let .floatList(list):
                if !list.value.isEmpty {
                    context[name] = Feature.Float(list.value[0])
                }
            case let .int64List(list):
                if !list.value.isEmpty {
                    context[name] = Feature.Int(Int(list.value[0]))
                }
            case .none:
                break
            }
        }
    }
    
    public mutating func set(_ name: String, feature: Feature?) {
        context[name] = feature
    }

    public func get(_ name: String) -> Feature? {
        return context[name]
    }
}
