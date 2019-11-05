# SwiftTFRecords
*TFRecords (.tfrecord) file format builder and reader for Swift*

[![Build Status](https://dev.azure.com/edgeWonders/TFRecords/_apis/build/status/JacopoMangiavacchi.TFRecords)](https://dev.azure.com/edgeWonders/TFRecords/_build/results?buildId=latest)


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

record.set("Int", feature: 1)
record.set("Float", feature: 2.3)
record.set("String", feature: "Jacopo 😃")
record.set("Bytes", feature: Feature.Bytes(Data([1, 2, 3, 4])))
record.set("IntArray", feature: Feature.IntArray([1, 2, 3, 4]))
record.set("FloatArray", feature: Feature.FloatArray([2.1, 2.2, 2.3]))

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
    print(record.get("Int")?.toInt())
    print(record.get("Float")?.toFloat())
    print(record.get("String")?.toString())
    print(record.get("Bytes")?.toBytes())
    print(record.get("IntArray")?.toIntArray())
    print(record.get("FloatArray")?.toFloatArray())
}

```
