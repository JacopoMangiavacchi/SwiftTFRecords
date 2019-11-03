import XCTest
@testable import SwiftTFRecords

final class BuilderReaderTests: XCTestCase {
    func testWriteReadTFRecord() {
        var recordIn = Record()
        
        recordIn.set("Int1", feature: 1)
        recordIn.set("Float2.3", feature: 2.3)
        recordIn.set("Bytes1234", feature: Feature.Bytes(Data([1, 2, 3, 4])))
        recordIn.set("StringJacopo", feature: "Jacopo 😃")
        
        let builder = Builder(withRecords: [recordIn])
        let tfRecordIn = builder.data
        
        let reader = Reader(withData: tfRecordIn)
        
        
        XCTAssertEqual(reader.count, 0)
    }

    static var allTests = [
        ("testWriteReadTFRecord", testWriteReadTFRecord),
    ]
}
