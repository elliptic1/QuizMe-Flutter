import 'package:flutter_sound/public/flutter_sound_recorder.dart';

class MicRepository {
  final FlutterSoundRecorder _recorder = FlutterSoundRecorder();

  Future<void> startRecording() async {
    await _recorder.startRecorder();
  }

  Future<void> stopRecording() async {
    await _recorder.stopRecorder();
  }
}
