import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'persistent_queue.dart';
import 'retry_policy.dart';

class NetworkUploader {
  final String endpoint;
  final String apiKey;
  final PersistentQueue queue;
  final RetryPolicy retryPolicy;
  bool _isUploading = false;

  NetworkUploader({
    required this.endpoint,
    required this.apiKey,
    PersistentQueue? queue,
    RetryPolicy? retryPolicy,
  })  : queue = queue ?? PersistentQueue(),
        retryPolicy = retryPolicy ?? RetryPolicy();

  void enqueue(Uint8List frame, {bool highPriority = false}) {
    queue.enqueue(frame, isHighPriority: highPriority);
  }

  Future<void> _uploadBatch(List<Uint8List> batch) async {
    final client = HttpClient();
    try {
      final request = await client.postUrl(Uri.parse(endpoint));
      request.headers.set('Authorization', 'Bearer $apiKey');
      request.headers.set('Content-Type', 'application/octet-stream');
      
      final payloadBuilder = BytesBuilder();
      for (final frame in batch) {
        final lengthBytes = ByteData(4)..setUint32(0, frame.length, Endian.big);
        payloadBuilder.add(lengthBytes.buffer.asUint8List());
        payloadBuilder.add(frame);
      }
      request.add(payloadBuilder.toBytes());
      await request.close();
    } finally {
      client.close();
    }
  }
}
