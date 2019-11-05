import XCTest
@testable import SwiftTFRecords

final class FeatureTests: XCTestCase {
    func testInt() {
        let feature: Feature = 17
        
        XCTAssertEqual(feature.toInt(), 17)
        XCTAssertNil(feature.toFloat())
        XCTAssertNil(feature.toBytes())
        XCTAssertNil(feature.toString())
        XCTAssertNil(feature.toIntArray())
        XCTAssertNil(feature.toFloatArray())
    }

    func testFloat() {
        let feature: Feature = 12.34

        XCTAssertEqual(feature.toFloat(), 12.34)
        XCTAssertNil(feature.toInt())
        XCTAssertNil(feature.toBytes())
        XCTAssertNil(feature.toString())
        XCTAssertNil(feature.toIntArray())
        XCTAssertNil(feature.toFloatArray())
    }

    func testBytes() {
        let feature: Feature = Feature.Bytes(Data([0, 202, 255, 44, 5]))

        XCTAssertEqual(feature.toBytes(), Data([0, 202, 255, 44, 5]))
        XCTAssertNil(feature.toInt())
        XCTAssertNil(feature.toFloat())
        XCTAssertNil(feature.toString())
        XCTAssertNil(feature.toIntArray())
        XCTAssertNil(feature.toFloatArray())
    }

    func testString() {
        let feature: Feature = "Jacopo 😃"

        XCTAssertEqual(feature.toString(), "Jacopo 😃")
        XCTAssertEqual(feature.toBytes(), Data([74, 97, 99, 111, 112, 111, 32, 240, 159, 152, 131]))
        XCTAssertNil(feature.toInt())
        XCTAssertNil(feature.toFloat())
        XCTAssertNil(feature.toIntArray())
        XCTAssertNil(feature.toFloatArray())
    }
    
    func testIntArray() {
        let feature: Feature = Feature.IntArray([1, 2, 3, 4])
        
        XCTAssertEqual(feature.toIntArray(), [1, 2, 3, 4])
        XCTAssertNil(feature.toFloat())
        XCTAssertNil(feature.toBytes())
        XCTAssertNil(feature.toString())
        XCTAssertNil(feature.toInt())
        XCTAssertNil(feature.toFloatArray())
    }

    func testFloatArray() {
        let feature: Feature = Feature.FloatArray([1.1, 2.2, 3.3, 4.4])
        
        XCTAssertEqual(feature.toFloatArray(), [1.1, 2.2, 3.3, 4.4])
        XCTAssertNil(feature.toFloat())
        XCTAssertNil(feature.toBytes())
        XCTAssertNil(feature.toString())
        XCTAssertNil(feature.toInt())
        XCTAssertNil(feature.toIntArray())
    }



    static var allTests = [
        ("testInt", testInt),
        ("testFloat", testFloat),
        ("testBytes", testBytes),
        ("testString", testString),
        ("testIntArray", testIntArray),
        ("testFloatArray", testFloatArray),
    ]
}
