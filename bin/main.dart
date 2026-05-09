import 'dart:async';
import 'dart:math';
import 'dart:io';

import '../lib/src/engine/network_uploader.dart';
import '../lib/src/engine/alert_engine.dart';
import '../lib/src/dashboard/live_stream_renderer.dart';
import '../lib/src/engine/ai_interceptor.dart';

void main() async {
  // 1. Initialize Core Engines
  final uploader = NetworkUploader();
  final alertEngine = AlertEngine();
  
  // 2. Initialize Dashboard Renderer
  final renderer = LiveStreamRenderer(
    uploader: uploader, 
    alertEngine: alertEngine
  );
  
  // 3. Initialize Interceptor
  final interceptor = AIInterceptor(renderer);

  // Start the terminal UI loop
  renderer.start();

  final random = Random();
  
  // Simulate incoming AI requests
  final trafficTimer = Timer.periodic(const Duration(milliseconds: 800), (timer) {
    // 10% chance of a massive latency spike to trigger the anomaly detector
    final isSpike = random.nextDouble() > 0.9;
    
    interceptor.logRequest(
      modelName: random.nextBool() ? 'gemini-pro' : 'gemini-flash',
      latencyMs: isSpike ? 2500.0 + random.nextInt(1000) : 300.0 + random.nextInt(200),
      tokens: 150 + random.nextInt(500),
      success: random.nextDouble() > 0.05, // 5% chance of failure
    );
  });

  // Keep the dashboard running for 2 minutes, then gracefully exit
  await Future.delayed(const Duration(minutes: 2));
  
  trafficTimer.cancel();
  renderer.stop();
  exit(0);
}
