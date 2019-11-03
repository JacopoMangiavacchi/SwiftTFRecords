import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(FeatureTests.allTests),
        testCase(RecordTests.allTests),
        testCase(TFRecordsTests.allTests),
    ]
}
#endif
