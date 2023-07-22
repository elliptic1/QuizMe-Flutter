import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sound/flutter_sound.dart';

import 'MicState.dart';

class MicCubit extends Cubit<MicState> {
  final FlutterSoundRecorder _recorder = FlutterSoundRecorder();
  StreamSubscription<RecordingDisposition>? _recordingSubscription;

  MicCubit() : super(MicInitial()) {
    _initialize();
  }

  Future<void> _initialize() async {
    try {
      await _recorder.openRecorder();
    } catch (e) {
      emit(MicError(e.toString()));
    }
  }

  Future<void> startRecording() async {
    try {
      await _recorder.startRecorder();
      _recordingSubscription = _recorder.onProgress!.listen((event) {
        emit(MicRecording(event.duration, event.decibels ?? 0.0));
      });
    } catch (e) {
      emit(MicError(e.toString()));
    }
  }

  Future<void> stopRecording() async {
    try {
      await _recorder.stopRecorder();
      await _recorder.closeRecorder();
      _recordingSubscription?.cancel();
      emit(MicStopped());
    } catch (e) {
      emit(MicError(e.toString()));
    }
  }

  @override
  Future<void> close() {
    _recordingSubscription?.cancel();
    return super.close();
  }
}
