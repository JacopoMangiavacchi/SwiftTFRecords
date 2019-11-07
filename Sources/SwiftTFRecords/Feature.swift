//
//  Feature.swift
//  
//
//  Created by Jacopo Mangiavacchi on 11/1/19.
//

import Foundation

public enum Feature {
    case FloatArray(_ value: [Float])
    case IntArray(_ value: [Int])
    case BytesArray(_ value: [Data])
}
