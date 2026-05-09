import 'dart:math';

class IdGenerator {
  static final _random = Random.secure();
  static const _chars = 'abcdefghijklmnopqrstuvwxyz0123456789';

  static String newTraceId() {
    final suffix = List.generate(8, (_) => _chars[_random.nextInt(_chars.length)]).join();
    return 'ls_${suffix}_${DateTime.now().millisecondsSinceEpoch}';
  }
}
