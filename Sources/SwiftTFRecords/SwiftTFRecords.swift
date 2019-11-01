import Foundation

// From proto !!
enum FeatureType {
   case Bytes, Float, Int64
}

protocol Feature {
   var type: FeatureType { get }
   var _value: Any { get }
}

struct FloatFeature : Feature {
   internal var type: FeatureType
   internal var _value: Any
   var value: Float { _value as! Float }
   
   init(_ value: Float) {
       self._value = value
       self.type = .Float
   }

   init(_ value: Double) {
       self._value = Float(value)
       self.type = .Float
   }
}

struct Int64Feature : Feature {
   internal var type: FeatureType
   internal var _value: Any
   var value: Int { _value as! Int }

   init(_ value: Int) {
       self._value = value
       self.type = .Int64
   }
}

struct BytesFeature : Feature {
   internal var type: FeatureType
   internal var _value: Any
   var value: [Int8] { _value as! [Int8] }

   init(_ value: [Int8]) {
       self._value = value
       self.type = .Bytes
   }
}

struct FeatureArray {
   internal let type: FeatureType
   internal let value: [Feature]
   
   init(_ value: [Float]) {
       self.type = .Float
       self.value = value.map{ FloatFeature($0) }
   }

   init(_ value: [Double]) {
       self.type = .Float
       self.value = value.map{ FloatFeature($0) }
   }

   init(_ value: [Int]) {
       self.type = .Int64
       self.value = value.map{ Int64Feature($0) }
   }

   init(_ value: [[Int8]]) {
       self.type = .Bytes
       self.value = value.map{ BytesFeature($0) }
   }
}

struct Record {
   var features = [String : Feature]()
   var featureArrays = [String : FeatureArray]()

   mutating func add(name: String, feature: Feature) {
       features[name] = feature
   }

   mutating func addArray(name: String, featureArray: FeatureArray) {
       featureArrays[name] = featureArray
   }

   func get(name: String) -> Feature? {
       return features[name]
   }

   func getArray(name: String) -> FeatureArray? {
       return featureArrays[name]
   }
}

//Utility Initializers for basic Literal types
//extension DataIO: ExpressibleByStringLiteral {
//    // By using 'StaticString' we disable string interpolation, for safety
//    public init(stringLiteral value: StaticString) {
//        self = DataIO.DataString(value: "\(value)")
//    }
//}

extension Int64Feature: ExpressibleByIntegerLiteral {
   public init(integerLiteral: IntegerLiteralType) {
       self = Int64Feature(Int(integerLiteral))
   }
}

//extension DataIO: ExpressibleByFloatLiteral {
//    public init(floatLiteral: FloatLiteralType) {
//        self = DataIO.DataFloat(value: Float(floatLiteral))
//    }
//}



class Main {
   init() {
       let i: Int64Feature = 1 //Int64Feature(1)
       
       var record = Record()
       record.add(name: "first", feature: Int64Feature(1))
       record.addArray(name: "second", featureArray: FeatureArray([1.0, 2.0, 3.0]))
   }
}








//// From proto !!
//enum FeatureType {
//    case bytes, float, int64
//}
//
//struct Feature {
//    let type: FeatureType
//    /*private*/ let _value: Any
//
//    // TODO ADD init()s for types
//
//    // TODO Getter()s for types
//}
//
//struct FeatureArray {
//    let type: FeatureType
//    /*private*/ let _value: [Any] // ? [Feature]
//
//    // TODO ADD init()s for array of types
//
//    // TODO Getter()s for arrat of types
//}
//
//struct Record {
//    var features = [String : Feature]()
//    var featureArrays = [String : FeatureArray]()
//
//    mutating func add(name: String, feature: Feature) {
//        features[name] = feature
//    }
//
//    mutating func addArray(name: String, featureArray: FeatureArray) {
//        featureArrays[name] = featureArray
//    }
//
//    func get(name: String) -> Feature? {
//        return features[name]
//    }
//
//    func getArray(name: String) -> FeatureArray? {
//        return featureArrays[name]
//    }
//}
//
//struct Builder {
//    var records: [Record]
//
//    init() {
//        records = [Record]()
//    }
//
//    init(withRecords records: [Record]) {
//        self.records = records
//    }
//
//    mutating func add(_ record: Record) {
//        records.append(record)
//    }
//}
//
//struct Reader {
//    let records: [Record]
//    var count: Int { records.count }
//
//    init(withRecords records: [Record]) {
//        self.records = records
//    }
//
//    init(withData data: Data) {
//        // TODO
//        self.records = [Record]()
//    }
//}
