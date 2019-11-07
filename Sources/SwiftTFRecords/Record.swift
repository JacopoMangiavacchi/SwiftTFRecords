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
            case let .FloatArray(value):
                var list = Tfrecords_FloatList()
                list.value = value
                tfFeature.floatList = list

            case let .IntArray(value):
                var list = Tfrecords_Int64List()
                list.value = value.map{ Int64($0) }
                tfFeature.int64List = list

            case let .BytesArray(value):
                var list = Tfrecords_BytesList()
                list.value = value
                tfFeature.bytesList = list
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
            case let .floatList(list):
                if !list.value.isEmpty {
                    features[name] = Feature.FloatArray(list.value)
                }
                
            case let .int64List(list):
                if !list.value.isEmpty {
                    features[name] = Feature.IntArray(list.value.map { Int($0) })
                }
                
            case let .bytesList(list):
                if !list.value.isEmpty {
                    features[name] = Feature.BytesArray(list.value)
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
        features[name]
    }
    
    public subscript(name: String) -> Feature? {
      get {
        features[name]
      }

      set (newValue) {
        features[name] = newValue
      }
    }
}
