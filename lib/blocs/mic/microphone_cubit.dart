import 'package:flutter_bloc/flutter_bloc.dart';
import 'MicState.dart';

class MicCubit extends Cubit<MicState> {
  MicCubit() : super(MicState.notListening);

  void toggle() {
    if (state == MicState.notListening) {
      print("Handling microphone...");
      emit(MicState.listening);
    } else {
      print("Stopping microphone...");
      emit(MicState.notListening);
    }
  }
}