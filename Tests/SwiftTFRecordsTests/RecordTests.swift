import XCTest
@testable import SwiftTFRecords

final class RecordTests: XCTestCase {
    func testPersistRecord() {
        var recordIn = Record()
        
        recordIn.set("Int1", feature: 1)
        recordIn.set("Float2.3", feature: 2.3)
        recordIn.set("Bytes1234", feature: Feature.Bytes(Data([1, 2, 3, 4])))
        recordIn.set("StringJacopo", feature: "Jacopo 😃")

        guard let data = recordIn.data else { return XCTFail() }
        
        let recordOut = Record(withData: data)
        
        XCTAssertEqual(recordOut.get("Int1")?.toInt(), 1)
        XCTAssertEqual(recordOut.get("Float2.3")?.toFloat(), 2.3)
        XCTAssertEqual(recordOut.get("Bytes1234")?.toBytes(), Data([1, 2, 3, 4]))
        XCTAssertEqual(recordOut.get("StringJacopo")?.toString(), "Jacopo 😃")
    }

    static var allTests = [
        ("testPersistRecord", testPersistRecord),
    ]
}
