import 'dart:math';

/// Exponential Backoff with Jitter - the industry standard
/// for distributed systems retrying failed network calls.
/// Prevents "Thundering Herd" problem where 1M devices
/// all retry at the same second after a server outage.
class RetryPolicy {
  final int maxAttempts;
  final Duration baseDelay;
  final Duration maxDelay;

  RetryPolicy({
    this.maxAttempts = 7,
    this.baseDelay = const Duration(milliseconds: 200),
    this.maxDelay = const Duration(seconds: 30),
  });

  /// Returns the delay for attempt N with random jitter applied
  Duration delayFor(int attempt) {
    if (attempt <= 0) return Duration.zero;
  // Exponential: 200ms, 400ms, 800ms, 1.6s, 3.2s...
    final exponential = baseDelay * pow(2, attempt - 1).toInt();

    // Cap at max delay
    final capped = exponential > maxDelay ? maxDelay : exponential;

    // Add jitter: randomize within 50% of the capped delay
    final jitterMs = Random().nextInt(capped.inMilliseconds ~/ 2);
    return capped + Duration(milliseconds: jitterMs);
  }

  bool shouldRetry(int attempt) => attempt < maxAttempts;
}
