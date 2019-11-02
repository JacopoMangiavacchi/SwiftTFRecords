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
        // TODO SAVE TF RECORD TO DATA
        var example = Tfrecords_SequenceExample()

        var intList = Tfrecords_Int64List()
        intList.value = [1]
        
        var feature = Tfrecords_Feature()
        feature.int64List = intList
        
        example.context.feature["aaa"] = feature

        var featureList = Tfrecords_FeatureList()
        featureList.feature = [feature]

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
