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
    case String(_ value: String)
    case FloatArray(_ value: [Float])
    case IntArray(_ value: [Int])
    case BytesArray(_ value: [Data])
    case StringArray(_ value: [String])

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
    
    public func toString() -> String? {
        switch self {
        case .String(let value):
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
    
    public func toStringArray() -> [String]? {
        switch self {
        case .StringArray(let value):
            return value
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
