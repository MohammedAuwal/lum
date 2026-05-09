import '../models/telemetry_packet.dart';
import '../dashboard/live_stream_renderer.dart';

/// Intercepts AI requests and converts them into telemetry packets
/// for the live dashboard and network uploader.
class AIInterceptor {
  final LiveStreamRenderer renderer;

  AIInterceptor(this.renderer);

  void logRequest({
    required String modelName,
    required double latencyMs,
    required int tokens,
    required bool success,
  }) {
    final packet = TelemetryPacket(
      traceId: DateTime.now().millisecondsSinceEpoch.toString(),
      modelName: modelName,
      timestamp: DateTime.now(),
      priority: success ? PacketPriority.low : PacketPriority.high,
      metrics: {
        'latency_ms': latencyMs,
        'tokens_estimate': tokens,
        'success': success,
        // Simulated memory delta for tracking
        'mem_delta_kb': success ? 50.0 : -10.0, 
      },
    );
    
    // Feed the visual dashboard
    renderer.ingestPacket(packet);
    
    // Process statistical anomalies
    renderer.alertEngine.process(packet);
    
    // Queue for network upload
    renderer.uploader.enqueue(packet);
  }
}
