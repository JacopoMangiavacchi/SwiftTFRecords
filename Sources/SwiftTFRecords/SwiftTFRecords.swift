//
//  SwiftTFRecords.swift
//
//
//  Created by Jacopo Mangiavacchi on 11/1/19.
//

import Foundation

public enum Feature {
    case Float(_ value: Float)
    case Int(_ value: Int)
    case Bytes(_ value: [UInt8])

    func toFloat() -> Float? {
        switch self {
        case .Float(let value):
            return value
        default:
            return nil
        }
    }

    func toInt() -> Int? {
        switch self {
        case .Int(let value):
            return value
        default:
            return nil
        }
    }
    
    func toBytes() -> [UInt8]? {
        switch self {
        case .Bytes(let value):
            return value
        default:
            return nil
        }
    }
    
    func toString() -> String? {
        switch self {
        case .Bytes(let value):
            if let string = String(bytes: value, encoding: .utf8) {
                return string
            }
            return nil
        default:
            return nil
        }
    }
}

// Utility Initializers for basic Literal types
extension Feature: ExpressibleByFloatLiteral {
    public init(floatLiteral: FloatLiteralType) {
        self = Feature.Float(Swift.Float(floatLiteral))
    }
}

extension Feature: ExpressibleByIntegerLiteral {
    public init(integerLiteral: IntegerLiteralType) {
        self = Feature.Int(integerLiteral)
    }
}

extension Feature: ExpressibleByStringLiteral {
    // By using 'StaticString' we disable string interpolation, for safety
    public init(stringLiteral value: StaticString) {
        self = Feature.Bytes(Array(String("\(value)").utf8))
    }
}

struct Record {
    var features: [String : Feature]
    var featureLists: [String : [Feature]]

    var data: Data {
        // TODO SAVE TF RECORD TO DATA
        Data()
    }

    init() {
        self.features = [String : Feature]()
        self.featureLists = [String : [Feature]]()
    }

    init(withData data: Data) {
        self.features = [String : Feature]()
        self.featureLists = [String : [Feature]]()

        // TODO READ TF RECORD FROM DATA
    }
    
    mutating func set(name: String, feature: Feature?) {
        features[name] = feature
    }

    mutating func setList(name: String, featureList: [Feature]?) {
        featureLists[name] = featureList
    }

    func get(name: String) -> Feature? {
        return features[name]
    }

    func getList(name: String) -> [Feature]? {
        return featureLists[name]
    }
}

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

struct Reader {
    var records: [Record] {
        // TODO
        [Record]()
    }
    
    var count: Int {
        // TODO
        records.count
    }

    init(withData data: Data) {
        // TODO
    }
    
    init(withFile file: String) {
        // TODO
    }

    // TODO ADD SUBSCRIPT

    // TODO ADD SUBSCRIPT WITH RANGE
}




//// TEST
//var record = Record()
//record.add(name: "first", feature: "1")
//record.addList(name: "second", featureList: [1.0, 2.0, 3.0])
