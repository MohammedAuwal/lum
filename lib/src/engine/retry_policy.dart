import 'dart:math';

class RetryPolicy {
  final int maxAttempts;
  final Duration baseDelay;
  final Duration maxDelay;

  RetryPolicy({
    this.maxAttempts = 7,
    this.baseDelay = const Duration(milliseconds: 200),
    this.maxDelay = const Duration(seconds: 30),
  });

  Duration delayFor(int attempt) {
    if (attempt <= 0) return Duration.zero;
    final exponential = baseDelay * pow(2, attempt - 1).toInt();
    final capped = exponential > maxDelay ? maxDelay : exponential;
    final jitterMs = Random().nextInt(capped.inMilliseconds ~/ 2);
    return capped + Duration(milliseconds: jitterMs);
  }

  bool shouldRetry(int attempt) => attempt < maxAttempts;
}
