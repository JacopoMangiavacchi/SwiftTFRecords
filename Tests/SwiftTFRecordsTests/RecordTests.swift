import XCTest
@testable import SwiftTFRecords

final class RecordTests: XCTestCase {
    func testPersistRecord() {
        var recordIn = Record()
        
        recordIn.set("Int", feature: 1)
        recordIn.set("Float", feature: 2.3)
        recordIn.set("Bytes", feature: Feature.Bytes(Data([1, 2, 3, 4])))
        recordIn.set("String", feature: "Jacopo 😃")

        guard let data = recordIn.data else { return XCTFail() }
        
        let recordOut = Record(withData: data)
        
        XCTAssertEqual(recordOut.get("Int")?.toInt(), 1)
        XCTAssertEqual(recordOut.get("Float")?.toFloat(), 2.3)
        XCTAssertEqual(recordOut.get("Bytes")?.toBytes(), Data([1, 2, 3, 4]))
        XCTAssertEqual(recordOut.get("String")?.toString(), "Jacopo 😃")
    }

    static var allTests = [
        ("testPersistRecord", testPersistRecord),
    ]
}
