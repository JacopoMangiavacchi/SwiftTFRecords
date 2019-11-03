import XCTest
@testable import SwiftTFRecords

final class BuilderReaderTests: XCTestCase {
    func testWriteReadTFRecord() {
        var record1 = Record()
        var record2 = Record()

        record1.set("Int", feature: 1)
        record1.set("Float", feature: 2.3)
        record1.set("Bytes", feature: Feature.Bytes(Data([1, 2, 3, 4])))
        record1.set("String", feature: "Jacopo 😃")

        record2.set("Int", feature: 2)
        record2.set("Float", feature: 4.6)
        record2.set("Bytes", feature: Feature.Bytes(Data([5, 6, 7, 8])))
        record2.set("String", feature: "Jacopo 😃😃")

        let builder = Builder(withRecords: [record1, record2])
        let tfRecordIn = builder.data
        
        let reader = Reader(withData: tfRecordIn)
        
        XCTAssertEqual(reader.records.count, 2)

        XCTAssertEqual(reader.records[0].context["Int"]?.toInt(), 1)
        XCTAssertEqual(reader.records[0].context["Float"]?.toFloat(), 2.3)
        XCTAssertEqual(reader.records[0].context["Bytes"]?.toBytes(), Data([1, 2, 3, 4]))
        XCTAssertEqual(reader.records[0].context["String"]?.toString(), "Jacopo 😃")

        XCTAssertEqual(reader.records[1].context["Int"]?.toInt(), 2)
        XCTAssertEqual(reader.records[1].context["Float"]?.toFloat(), 4.6)
        XCTAssertEqual(reader.records[1].context["Bytes"]?.toBytes(), Data([5, 6, 7, 8]))
        XCTAssertEqual(reader.records[1].context["String"]?.toString(), "Jacopo 😃😃")
    }

    static var allTests = [
        ("testWriteReadTFRecord", testWriteReadTFRecord),
    ]
}
