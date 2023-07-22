
import 'package:flutter_bloc/flutter_bloc.dart';

import 'MicEvent.dart';
import 'MicRepository.dart';
import 'MicState.dart';

class MicBloc extends Bloc<MicEvent, MicState> {
  final MicRepository micRepository;

  MicBloc({required this.micRepository}) : super(MicInitial());

  @override
  Stream<MicState> mapEventToState(MicEvent event) async* {
    if (event is StartRecording) {
      try {
        await micRepository.startRecording();
        yield const MicRecording(Duration.zero, double.negativeInfinity);
      } catch (e) {
        yield MicError("Error while recording: $e");
      }
    } else if (event is StopRecording) {
      try {
        await micRepository.stopRecording();
        yield MicStopped();
      } catch (e) {
        yield MicError("Error while stopping: $e");
      }
    }
  }
}
