import 'dart:collection';
import 'dart:typed_data';

class PersistentQueue {
  final int maxCapacity;
  final _highPriority = Queue<Uint8List>();
  final _normalPriority = Queue<Uint8List>();

  int get length => _highPriority.length + _normalPriority.length;
  bool get isEmpty => _highPriority.isEmpty && _normalPriority.isEmpty;
  bool get isFull => length >= maxCapacity;

  PersistentQueue({this.maxCapacity = 5000});

  void enqueue(Uint8List frame, {bool isHighPriority = false}) {
    if (isFull) {
      if (_normalPriority.isNotEmpty) {
        _normalPriority.removeFirst();
      } else {
        return;
      }
    }
    if (isHighPriority) {
      _highPriority.addLast(frame);
    } else {
      _normalPriority.addLast(frame);
    }
  }

  Uint8List? dequeue() {
    if (_highPriority.isNotEmpty) return _highPriority.removeFirst();
    if (_normalPriority.isNotEmpty) return _normalPriority.removeFirst();
    return null;
  }

  List<Uint8List> dequeueBatch(int batchSize) {
    final batch = <Uint8List>[];
    for (int i = 0; i < batchSize && !isEmpty; i++) {
      final frame = dequeue();
      if (frame != null) batch.add(frame);
    }
    return batch;
  }

  void clear() {
    _highPriority.clear();
    _normalPriority.clear();
  }
}
