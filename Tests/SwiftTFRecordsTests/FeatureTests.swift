import XCTest
@testable import SwiftTFRecords

final class FeatureTests: XCTestCase {
    func testFloat() {
        let feature: Feature = 12.34

        XCTAssertEqual(feature.toFloat(), 12.34)
        XCTAssertNil(feature.toInt())
        XCTAssertNil(feature.toBytes())
        XCTAssertNil(feature.toString())
        XCTAssertNil(feature.toIntArray())
        XCTAssertNil(feature.toFloatArray())
        XCTAssertNil(feature.toBytesArray())
        XCTAssertNil(feature.toStringArray())
    }

    func testInt() {
        let feature: Feature = 17
        
        XCTAssertEqual(feature.toInt(), 17)
        XCTAssertNil(feature.toFloat())
        XCTAssertNil(feature.toBytes())
        XCTAssertNil(feature.toString())
        XCTAssertNil(feature.toIntArray())
        XCTAssertNil(feature.toFloatArray())
        XCTAssertNil(feature.toBytesArray())
        XCTAssertNil(feature.toStringArray())
    }

    func testBytes() {
        let feature: Feature = Feature.Bytes(Data([0, 202, 255, 44, 5]))

        XCTAssertEqual(feature.toBytes(), Data([0, 202, 255, 44, 5]))
        XCTAssertNil(feature.toInt())
        XCTAssertNil(feature.toFloat())
        XCTAssertNil(feature.toString())
        XCTAssertNil(feature.toIntArray())
        XCTAssertNil(feature.toFloatArray())
        XCTAssertNil(feature.toBytesArray())
        XCTAssertNil(feature.toStringArray())
    }

    func testString() {
        let feature: Feature = "Jacopo 😃"

        XCTAssertEqual(feature.toString(), "Jacopo 😃")
        XCTAssertNil(feature.toBytes())
        XCTAssertNil(feature.toInt())
        XCTAssertNil(feature.toFloat())
        XCTAssertNil(feature.toIntArray())
        XCTAssertNil(feature.toFloatArray())
        XCTAssertNil(feature.toBytesArray())
        XCTAssertNil(feature.toStringArray())
    }
    
    func testString2() {
        let feature: Feature = Feature.String("Jacopo 😃")

        XCTAssertEqual(feature.toString(), "Jacopo 😃")
        XCTAssertNil(feature.toBytes())
        XCTAssertNil(feature.toInt())
        XCTAssertNil(feature.toFloat())
        XCTAssertNil(feature.toIntArray())
        XCTAssertNil(feature.toFloatArray())
        XCTAssertNil(feature.toBytesArray())
        XCTAssertNil(feature.toStringArray())
    }
    
    func testFloatArray() {
        let feature: Feature = [1.1, 2.2, 3.3, 4.4]

        XCTAssertEqual(feature.toFloatArray(), [1.1, 2.2, 3.3, 4.4])
        XCTAssertNil(feature.toFloat())
        XCTAssertNil(feature.toBytes())
        XCTAssertNil(feature.toString())
        XCTAssertNil(feature.toInt())
        XCTAssertNil(feature.toIntArray())
        XCTAssertNil(feature.toBytesArray())
        XCTAssertNil(feature.toStringArray())
    }

    func testIntArray() {
        let feature: Feature = Feature.IntArray([1, 2, 3, 4])
        
        XCTAssertEqual(feature.toIntArray(), [1, 2, 3, 4])
        XCTAssertNil(feature.toFloat())
        XCTAssertNil(feature.toBytes())
        XCTAssertNil(feature.toString())
        XCTAssertNil(feature.toInt())
        XCTAssertNil(feature.toFloatArray())
        XCTAssertNil(feature.toBytesArray())
        XCTAssertNil(feature.toStringArray())
    }

    func testBytesArray() {
        let feature: Feature = Feature.BytesArray([Data([1, 2]), Data([3, 4])])
        
        XCTAssertEqual(feature.toBytesArray(), [Data([1, 2]), Data([3, 4])])
        XCTAssertNil(feature.toFloat())
        XCTAssertNil(feature.toBytes())
        XCTAssertNil(feature.toString())
        XCTAssertNil(feature.toInt())
        XCTAssertNil(feature.toFloatArray())
        XCTAssertNil(feature.toIntArray())
        XCTAssertNil(feature.toStringArray())
    }

    func testStringArray() {
        let feature: Feature = Feature.StringArray(["a", "b", "c"])
        
        XCTAssertEqual(feature.toStringArray(), ["a", "b", "c"])
        XCTAssertNil(feature.toFloat())
        XCTAssertNil(feature.toBytes())
        XCTAssertNil(feature.toString())
        XCTAssertNil(feature.toInt())
        XCTAssertNil(feature.toFloatArray())
        XCTAssertNil(feature.toIntArray())
        XCTAssertNil(feature.toBytesArray())
    }

    static var allTests = [
        ("testFloat", testFloat),
        ("testInt", testInt),
        ("testBytes", testBytes),
        ("testString", testString),
        ("testString2", testString2),
        ("testFloatArray", testFloatArray),
        ("testIntArray", testIntArray),
        ("testBytesArray", testBytesArray),
        ("testStringArray", testStringArray),
    ]
}
