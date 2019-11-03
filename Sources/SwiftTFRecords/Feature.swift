//
//  Feature.swift
//  
//
//  Created by Jacopo Mangiavacchi on 11/1/19.
//

import Foundation

public enum Feature {
    case Bytes(_ value: Data)
    case Float(_ value: Float)
    case Int(_ value: Int)

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
        self = Feature.Bytes(Data(String("\(value)").utf8))
    }
}
