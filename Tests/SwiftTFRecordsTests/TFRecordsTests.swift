import XCTest
@testable import SwiftTFRecords

final class TFRecordsTests: XCTestCase {
    func testWriteReadTFRecord() {
        var record1 = Record()
        var record2 = Record()

        record1["Int"] = 1
        record1["Float"] = 2.3
        record1["Bytes"] = Feature.Bytes(Data([1, 2, 3, 4]))
        record1["String"] = "Jacopo 😃"
        record1["IntArray"] = Feature.IntArray([1, 2, 3, 4])
        record1["FloatArray"] = [2.1, 2.2, 2.3]
        record1["BytesArray"] = Feature.BytesArray([Data([1, 2]), Data([3, 4])])
        record1["StringArray"] = Feature.StringArray(["a", "b", "c"])

        record2["Int"] = 2
        record2["Float"] = 4.6
        record2["Bytes"] = Feature.Bytes(Data([5, 6, 7, 8]))
        record2["String"] = "Jacopo 😃😃"
        record2["IntArray"] = Feature.IntArray([1, 2, 3, 4])
        record2["FloatArray"] = [2.1, 2.2, 2.3]
        record2["BytesArray"] = Feature.BytesArray([Data([1, 2]), Data([3, 4])])
        record2["StringArray"] = Feature.StringArray(["a", "b", "c"])

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
        XCTAssertEqual(tfRecordOut.records[0].features["BytesArray"]?.toBytesArray(), [Data([1, 2]), Data([3, 4])])
        XCTAssertEqual(tfRecordOut.records[0].features["StringArray"]?.toStringArray(), ["a", "b", "c"])

        XCTAssertEqual(tfRecordOut.records[1].features["Int"]?.toInt(), 2)
        XCTAssertEqual(tfRecordOut.records[1].features["Float"]?.toFloat(), 4.6)
        XCTAssertEqual(tfRecordOut.records[1].features["Bytes"]?.toBytes(), Data([5, 6, 7, 8]))
        XCTAssertEqual(tfRecordOut.records[1].features["String"]?.toString(), "Jacopo 😃😃")
        XCTAssertEqual(tfRecordOut.records[1].features["IntArray"]?.toIntArray(), [1, 2, 3, 4])
        XCTAssertEqual(tfRecordOut.records[1].features["FloatArray"]?.toFloatArray(), [2.1, 2.2, 2.3])
        XCTAssertEqual(tfRecordOut.records[1].features["BytesArray"]?.toBytesArray(), [Data([1, 2]), Data([3, 4])])
        XCTAssertEqual(tfRecordOut.records[1].features["StringArray"]?.toStringArray(), ["a", "b", "c"])
    }

    static var allTests = [
        ("testWriteReadTFRecord", testWriteReadTFRecord),
    ]
}
