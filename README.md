# SwiftTFRecords
**TFRecords (.tfrecord) file format builder and reader for Swift**

![](https://github.com/jacopomangiavacchi/swifttfrecords/workflows/Swift/badge.svg)

The TFRecords format is briefly documented
[here](https://www.tensorflow.org/api_guides/python/python_io#tfrecords_format_details),
and described as the recommended format for feeding data into TenosorFlow
[here](https://www.tensorflow.org/api_guides/python/reading_data#standard_tensorflow_format)
and
[here](https://www.tensorflow.org/api_guides/python/io_ops#example_protocol_buffer).

This library facilitates producing and importing data in the TFRecords format directly in
Swift. 

The library is not "official" - it is not part of TensorFlow, and it is not maintained by the TensorFlow team.

## Usage - Produce a TFRecords file

The example below covers recommended API usage for generating a TFRecords file.

```swift
import SwiftTFRecords

var record = Record()

record["Int"] = 1
record["Float"] = 2.3
record["String"] = "Jacopo 😃"
record["FloatArray"] = [2.1, 2.2, 2.3]
record["Bytes"] = Feature.Bytes(Data([1, 2, 3, 4])
record["IntArray"] = Feature.IntArray([1, 2, 3, 4])

let tfRecord = TFRecords(withRecords: [record])

tfRecord.data.write(to: URL(fileURLWithPath: "file.tfrecord"))

```

## Usage - Import a TFRecords file 

The example below covers recommended API usage for read a TFRecords file.

```swift
import SwiftTFRecords

let data = try Data(contentsOf: URL(fileURLWithPath: "file.tfrecord"))

let tfRecord = TFRecords(withData: data)

for record in tfRecord.records {
    print("---")
    print(record["Int"]?.toInt())
    print(record["Float"]?.toFloat())
    print(record["String"]?.toString())
    print(record["FloatArray"]?.toFloatArray())
    print(record["Bytes"]?.toBytes())
    print(record["IntArray"]?.toIntArray())
}

```
