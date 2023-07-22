
import 'package:equatable/equatable.dart';

abstract class MicEvent extends Equatable {
  const MicEvent();

  @override
  List<Object> get props => [];
}

class StartRecording extends MicEvent {}

class StopRecording extends MicEvent {}

class RecordingError extends MicEvent {}
