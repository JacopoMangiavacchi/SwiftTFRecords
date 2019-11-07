//
//  Feature.swift
//
//
//  Created by Jacopo Mangiavacchi on 11/6/19.
//

import Foundation

// Easy cast
extension Feature {
    public func toFloatArray() -> [Float]? {
        switch self {
        case .FloatArray(let value):
            return value
            
        default:
            return nil
        }
    }

    public func toIntArray() -> [Int]? {
        switch self {
        case .IntArray(let value):
            return value
            
        default:
            return nil
        }
    }
    
    public func toBytesArray() -> [Data]? {
        switch self {
        case .BytesArray(let value):
            return value
            
        default:
            return nil
        }
    }
}

//String support
extension Feature {
    // Not possible to define String as enum case as TFRecords protobut only manage generic Bytes (Data)
    public static func String(_ value: Swift.String) -> Self {
        return Feature.Bytes(Data(Swift.String("\(value)").utf8))
    }
    
    // Not possible to define StringArray as enum case as TFRecords protobut only manage generic Bytes (Data)
    public static func StringArray(_ value: [Swift.String]) -> Self {
        return Feature.BytesArray(value.map{ Data(Swift.String("\($0)").utf8) })
    }

    public func toString() -> Swift.String? {
        switch self {
        case .BytesArray(let value):
            if value.count == 1, let string = Swift.String(bytes: value[0], encoding: .utf8) {
                return string
            }
            return nil
            
        default:
            return nil
        }
    }
        
    public func toStringArray() -> [Swift.String]? {
        switch self {
        case .BytesArray(let value):
            let stringArray = value.compactMap{ Swift.String(bytes: $0, encoding: .utf8) }
            return stringArray.isEmpty ? nil : stringArray
            
        default:
            return nil
        }
    }
}

// Single instance support
extension Feature {
    public static func Float(_ value: Swift.Float) -> Self {
        return Feature.FloatArray([value])
    }

    public static func Int(_ value: Swift.Int) -> Self {
        return Feature.IntArray([value])
    }

    public static func Bytes(_ value: Data) -> Self {
        return Feature.BytesArray([value])
    }
        
    public func toFloat() -> Float? {
        switch self {
        case .FloatArray(let value):
            if value.count == 1 {
                return value[0]
            }
            return nil
            
        default:
            return nil
        }
    }

    public func toInt() -> Int? {
        switch self {
        case .IntArray(let value):
            if value.count == 1 {
                return value[0]
            }
            return nil
            
        default:
            return nil
        }
    }
    
    public func toBytes() -> Data? {
        switch self {
        case .BytesArray(let value):
            if value.count == 1 {
                return value[0]
            }
            return nil
            
        default:
            return nil
        }
    }
}

// Float Literal support
extension Feature: ExpressibleByFloatLiteral {
    public init(floatLiteral: FloatLiteralType) {
        self = Feature.Float(Swift.Float(floatLiteral))
    }
}

// Int Literal support
extension Feature: ExpressibleByIntegerLiteral {
    public init(integerLiteral: IntegerLiteralType) {
        self = Feature.Int(integerLiteral)
    }
}

// String Literal support
extension Feature: ExpressibleByStringLiteral {
    // By using 'StaticString' we disable string interpolation, for safety
    public init(stringLiteral value: StaticString) {
        self = Feature.String(Swift.String("\(value)"))
    }
}

// Float Array Literal support
extension Feature: ExpressibleByArrayLiteral {
    // Default to Float Array
    public init(arrayLiteral elements: Float...) {
        self = Feature.FloatArray(elements)
    }

//    public init(arrayLiteral elements: Int...) {
//        self = Feature.IntArray(elements)
//    }
}

