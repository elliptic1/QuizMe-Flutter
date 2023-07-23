// mic_cubit.dart
import 'package:equatable/equatable.dart';

abstract class MicState extends Equatable {
  const MicState();

  @override
  List<Object> get props => [];
}

class MicIdle extends MicState {}

class MicRecording extends MicState {
  final Duration duration;
  final double decibels;

  const MicRecording(this.duration, this.decibels);

  @override
  List<Object> get props => [duration, decibels];
}

class MicError extends MicState {
  final String message;

  const MicError(this.message);
}
