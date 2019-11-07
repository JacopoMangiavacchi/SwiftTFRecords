import XCTest
@testable import SwiftTFRecords

final class RecordTests: XCTestCase {
    func testPersistRecord() {
        var recordIn = Record()
        
        recordIn.set("Float", feature: 2.3)
        recordIn.set("Int", feature: 1)
        recordIn.set("Bytes", feature: Feature.Bytes(Data([1, 2, 3, 4])))
        recordIn.set("String", feature: "Jacopo 😃")
        recordIn.set("FloatArray", feature: [2.1, 2.2, 2.3])
        recordIn.set("IntArray", feature: Feature.IntArray([1, 2, 3, 4]))
        recordIn.set("BytesArray", feature: Feature.BytesArray([Data([1, 2]), Data([3, 4])]))
        recordIn.set("StringArray", feature: Feature.StringArray(["a", "b", "c"]))

        guard let data = recordIn.data else { return XCTFail() }
        
        let recordOut = Record(withData: data)
        
        XCTAssertEqual(recordOut.get("Float")?.toFloat(), 2.3)
        XCTAssertEqual(recordOut.get("Int")?.toInt(), 1)
        XCTAssertEqual(recordOut.get("Bytes")?.toBytes(), Data([1, 2, 3, 4]))
        XCTAssertEqual(recordOut.get("String")?.toString(), "Jacopo 😃")
        XCTAssertEqual(recordOut.get("FloatArray")?.toFloatArray(), [2.1, 2.2, 2.3])
        XCTAssertEqual(recordOut.get("IntArray")?.toIntArray(), [1, 2, 3, 4])
        XCTAssertEqual(recordOut.get("BytesArray")?.toBytesArray(), [Data([1, 2]), Data([3, 4])])
        XCTAssertEqual(recordOut.get("StringArray")?.toStringArray(), ["a", "b", "c"])
    }

    func testSubsriptRecord() {
        var recordIn = Record()
        
        recordIn["Int"] = 1
        recordIn["Float"] = 2.3
        recordIn["Bytes"] = Feature.Bytes(Data([1, 2, 3, 4]))
        recordIn["String"] = "Jacopo 😃"
        recordIn["IntArray"] = Feature.IntArray([1, 2, 3, 4])
        recordIn["FloatArray"] = [2.1, 2.2, 2.3]

        guard let data = recordIn.data else { return XCTFail() }
        
        let recordOut = Record(withData: data)
        
        XCTAssertEqual(recordOut["Int"]?.toInt(), 1)
        XCTAssertEqual(recordOut["Float"]?.toFloat(), 2.3)
        XCTAssertEqual(recordOut["Bytes"]?.toBytes(), Data([1, 2, 3, 4]))
        XCTAssertEqual(recordOut["String"]?.toString(), "Jacopo 😃")
        XCTAssertEqual(recordOut["IntArray"]?.toIntArray(), [1, 2, 3, 4])
        XCTAssertEqual(recordOut["FloatArray"]?.toFloatArray(), [2.1, 2.2, 2.3])
    }

    static var allTests = [
        ("testPersistRecord", testPersistRecord),
        ("testSubsriptRecord", testSubsriptRecord),
    ]
}
