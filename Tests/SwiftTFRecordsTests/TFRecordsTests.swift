import XCTest
@testable import SwiftTFRecords

final class TFRecordsTests: XCTestCase {
    func testWriteReadTFRecord() {
        var record1 = Record()
        var record2 = Record()

        record1.set("Int", feature: 1)
        record1.set("Float", feature: 2.3)
        record1.set("Bytes", feature: Feature.Bytes(Data([1, 2, 3, 4])))
        record1.set("String", feature: "Jacopo 😃")
        record1.set("IntArray", feature: Feature.IntArray([1, 2, 3, 4]))
        record1.set("FloatArray", feature: [2.1, 2.2, 2.3])

        record2.set("Int", feature: 2)
        record2.set("Float", feature: 4.6)
        record2.set("Bytes", feature: Feature.Bytes(Data([5, 6, 7, 8])))
        record2.set("String", feature: "Jacopo 😃😃")
        record2.set("IntArray", feature: Feature.IntArray([1, 2, 3, 4]))
        record2.set("FloatArray", feature: [2.1, 2.2, 2.3])

        let tfRecordIn = TFRecords(withRecords: [record1, record2])
        let tfRecordInData = tfRecordIn.data
        
        let tfRecordOut = TFRecords(withData: tfRecordInData)
        
        XCTAssertEqual(tfRecordOut.records.count, 2)

        XCTAssertEqual(tfRecordOut.records[0].features["Int"]?.toInt(), 1)
        XCTAssertEqual(tfRecordOut.records[0].features["Float"]?.toFloat(), 2.3)
        XCTAssertEqual(tfRecordOut.records[0].features["Bytes"]?.toBytes(), Data([1, 2, 3, 4]))
        XCTAssertEqual(tfRecordOut.records[0].features["String"]?.toString(), "Jacopo 😃")
        XCTAssertEqual(tfRecordOut.records[0].features["IntArray"]?.toIntArray(), [1, 2, 3, 4])
        XCTAssertEqual(tfRecordOut.records[0].features["FloatArray"]?.toFloatArray(), [2.1, 2.2, 2.3])

        XCTAssertEqual(tfRecordOut.records[1].features["Int"]?.toInt(), 2)
        XCTAssertEqual(tfRecordOut.records[1].features["Float"]?.toFloat(), 4.6)
        XCTAssertEqual(tfRecordOut.records[1].features["Bytes"]?.toBytes(), Data([5, 6, 7, 8]))
        XCTAssertEqual(tfRecordOut.records[1].features["String"]?.toString(), "Jacopo 😃😃")
        XCTAssertEqual(tfRecordOut.records[1].features["IntArray"]?.toIntArray(), [1, 2, 3, 4])
        XCTAssertEqual(tfRecordOut.records[1].features["FloatArray"]?.toFloatArray(), [2.1, 2.2, 2.3])
    }

    static var allTests = [
        ("testWriteReadTFRecord", testWriteReadTFRecord),
    ]
}
