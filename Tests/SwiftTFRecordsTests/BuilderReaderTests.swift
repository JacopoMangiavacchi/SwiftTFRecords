import XCTest
@testable import SwiftTFRecords

final class BuilderReaderTests: XCTestCase {
    func testWriteReadTFRecord() {
        var record1 = Record()
        var record2 = Record()

        record1.set("Int1", feature: 1)
        record1.set("Float2.3", feature: 2.3)
        record1.set("Bytes1234", feature: Feature.Bytes(Data([1, 2, 3, 4])))
        record1.set("StringJacopo", feature: "Jacopo 😃")

        record2.set("Int1", feature: 2)
        record2.set("Float2.3", feature: 4.6)
        record2.set("Bytes1234", feature: Feature.Bytes(Data([5, 6, 7, 8])))
        record2.set("StringJacopo", feature: "Jacopo 😃😃")

        let builder = Builder(withRecords: [record1, record2])
        let tfRecordIn = builder.data
        
        let reader = Reader(withData: tfRecordIn)
        
        
        XCTAssertEqual(reader.count, 0)
    }

    static var allTests = [
        ("testWriteReadTFRecord", testWriteReadTFRecord),
    ]
}
