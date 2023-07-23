// MicRepository.dart
import 'dart:async';
import 'dart:developer';
import 'dart:typed_data';

import 'package:mic_stream/mic_stream.dart';

class MicRepository {
  StreamSubscription<Uint8List>? _micStreamSubscription;
  Duration silenceDuration =
      const Duration(seconds: 2); // Duration of silence to wait before stopping
  DateTime? lastSoundTime; // The last time sound was detected
  double volumeThreshold = 0.5;

  Future<void> startRecording(void Function(List<int> samples) onData) async {
    log("startRecording()");
    Stream<Uint8List>? stream = await MicStream.microphone(sampleRate: 44100);
    _micStreamSubscription = stream?.listen((samples) {
      // Call the onData callback with the new samples
      onData(samples);
    }, onError: (e) {
      log("Error in microphone stream: $e");
    });
  }

  Future<void> stopRecording() async {
    await _micStreamSubscription?.cancel();
    _micStreamSubscription = null;
  }

  double calculateVolume(List<int> samples) {
    int sum = 0;
    for (int sample in samples) {
      sum += sample.abs();
    }
    return sum / samples.length;
  }
}
