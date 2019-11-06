//
//  Record.swift
//  
//
//  Created by Jacopo Mangiavacchi on 11/1/19.
//

import Foundation

public struct Record {
    public var features: [String : Feature]

    public var data: Data? {
        var example = Tfrecords_Example()

        for (name, feature) in features {
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
                
            case let .FloatArray(value):
                var list = Tfrecords_FloatList()
                list.value = value
                tfFeature.floatList = list

            case let .IntArray(value):
                var list = Tfrecords_Int64List()
                list.value = value.map{ Int64($0) }
                tfFeature.int64List = list
            }
            
            example.features.feature[name] = tfFeature
        }
        
        return try? example.serializedData()
    }

    public init() {
        self.features = [String : Feature]()
    }

    public init(withData data: Data) {
        self.features = [String : Feature]()
        
        guard let example = try? Tfrecords_Example(serializedData: data) else { return }

        for (name, feature) in example.features.feature {
            switch feature.kind {
            case let .bytesList(list):
                if !list.value.isEmpty {
                    features[name] = Feature.Bytes(list.value[0])
                }
            case let .floatList(list):
                switch list.value.count {
                case 0:
                    break
                case 1:
                    features[name] = Feature.Float(list.value[0])
                default:
                    features[name] = Feature.FloatArray(list.value)
                }
            case let .int64List(list):
                switch list.value.count {
                case 0:
                    break
                case 1:
                    features[name] = Feature.Int(Int(list.value[0]))
                default:
                    features[name] = Feature.IntArray(list.value.map { Int($0) })
                }
                if !list.value.isEmpty {
                }
            case .none:
                break
            }
        }
    }
    
    public mutating func set(_ name: String, feature: Feature?) {
        features[name] = feature
    }

    public func get(_ name: String) -> Feature? {
        return features[name]
    }
}
