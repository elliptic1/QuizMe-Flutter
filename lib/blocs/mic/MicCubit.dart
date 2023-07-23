// MicCubit.dart
import 'dart:async';
import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/repositories/MicRepository.dart';
import 'MicState.dart';

class MicCubit extends Cubit<MicState> {
  final MicRepository _micRepository;
  int _sampleCount = 0;

  MicCubit(this._micRepository) : super(MicIdle());

  Future<void> startRecording() async {
    log("MicCubit - startRecording");
    try {
      _sampleCount = 0;
      await _micRepository.startRecording((samples) {
        _sampleCount += samples.length;
        Duration duration = Duration(milliseconds: (_sampleCount / 44.1).round());
        // Here you can process the audio samples and emit a new state
        emit(MicRecording(duration, 0.0)); // Decibels is set to 0.0 as we're not calculating it
      });
    } catch (e) {
      String msg = "Failed to start recording: ${e.toString()}";
      log(msg);
      emit(MicError(msg));
      await stopRecording();
    }
  }

  Future<void> stopRecording() async {
    try {
      await _micRepository.stopRecording();
      emit(MicIdle());
    } catch (e) {
      String msg = "Failed to stop recording: ${e.toString()}";
      log(msg);
      emit(MicError(msg));
    }
  }
}
