//
//  Record.swift
//  
//
//  Created by Jacopo Mangiavacchi on 11/1/19.
//

import Foundation

struct Record {
    var context: [String : Feature]
    var featureLists: [String : [Feature]]

    var data: Data? {
        var example = Tfrecords_SequenceExample()

        // Add context
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
            
            example.context.feature[name] = tfFeature
        }
        
        // Add featureLists
        for (name, featureList) in featureLists {
            if !featureList.isEmpty {
                var tfFeature = Tfrecords_Feature()
                
                switch featureList[0] {
                case let .Bytes(value):
                    var list = Tfrecords_BytesList()
                    list.value = featureList.compactMap{ $0.toBytes() }
                    tfFeature.bytesList = list

                case let .Float(value):
                    var list = Tfrecords_FloatList()
                    list.value = featureList.compactMap{ $0.toFloat() }
                    tfFeature.floatList = list

                case let .Int(value):
                    var list = Tfrecords_Int64List()
                    list.value = featureList.compactMap{ $0.toInt64() }
                    tfFeature.int64List = list
                }
                
                var tfFeatureList = Tfrecords_FeatureList()
                tfFeatureList.feature = tfFeature

                example.featureLists.featureList[name] = tfFeatureList
            }
        }

        
        
        
        
        var tfFeature = Tfrecords_Feature()

        var list = Tfrecords_Int64List()
        list.value = [Int64(1)]
        tfFeature.int64List = list

        
        var featureList = Tfrecords_FeatureList()
        featureList.feature = [tfFeature]

        example.featureLists.featureList["bbb"] = featureList
        
        return try? example.serializedData()
    }

    init() {
        self.context = [String : Feature]()
        self.featureLists = [String : [Feature]]()
    }

    init(withData data: Data) {
        self.context = [String : Feature]()
        self.featureLists = [String : [Feature]]()

        // TODO READ TF RECORD FROM DATA
    }
    
    mutating func setContext(name: String, feature: Feature?) {
        context[name] = feature
    }

    mutating func setList(name: String, featureList: [Feature]?) {
        featureLists[name] = featureList
    }

    func getContext(name: String) -> Feature? {
        return context[name]
    }

    func getList(name: String) -> [Feature]? {
        return featureLists[name]
    }
}

//// TEST
//var record = Record()
//record.addContext(name: "first", feature: "1")
//record.addList(name: "second", featureList: [1.0, 2.0, 3.0])
