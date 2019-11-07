//
//  Feature.swift
//  
//
//  Created by Jacopo Mangiavacchi on 11/1/19.
//

import Foundation

public enum Feature {
    case Float(_ value: Float)
    case Int(_ value: Int)
    case Bytes(_ value: Data)
    case FloatArray(_ value: [Float])
    case IntArray(_ value: [Int])
    case BytesArray(_ value: [Data])

    // Not possible to define String as enum case as TFRecords protobut only manage generic Bytes (Data)
    public static func String(_ value: Swift.String) -> Self {
        return Feature.Bytes(Data(Swift.String("\(value)").utf8))
    }
    
    // Not possible to define StringArray as enum case as TFRecords protobut only manage generic Bytes (Data)
    public static func StringArray(_ value: [Swift.String]) -> Self {
        return Feature.BytesArray(value.map{ Data(Swift.String("\($0)").utf8) })
    }
    
    public func toFloat() -> Float? {
        switch self {
        case .Float(let value):
            return value
        default:
            return nil
        }
    }

    public func toInt() -> Int? {
        switch self {
        case .Int(let value):
            return value
        default:
            return nil
        }
    }
    
    public func toBytes() -> Data? {
        switch self {
        case .Bytes(let value):
            return value
        default:
            return nil
        }
    }
    
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
    
    public func toString() -> Swift.String? {
        switch self {
        case .Bytes(let value):
            if let string = Swift.String(bytes: value, encoding: .utf8) {
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
            return value.compactMap{ Swift.String(bytes: $0, encoding: .utf8) }
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
        self = Feature.String(Swift.String("\(value)"))
    }
}

extension Feature: ExpressibleByArrayLiteral {
    // Default to Float Array
    public init(arrayLiteral elements: Float...) {
        self = Feature.FloatArray(elements)
    }

//    public init(arrayLiteral elements: Int...) {
//        self = Feature.IntArray(elements)
//    }
}
