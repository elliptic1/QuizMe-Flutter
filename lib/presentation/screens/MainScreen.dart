// mic_text.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/mic/MicState.dart';
import '../../blocs/mic/MicCubit.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MicCubit, MicState>(
      builder: (context, state) {
        if (state is MicIdle) {
          return const Center(
              child: Text('Press the microphone button to start speaking'));
        } else if (state is MicRecording) {
          return Center(child: Text('Recording... Duration: ${state.duration} seconds, Decibels: ${state.decibels} dB'));
        } else if (state is MicError) {
          return Center(child: Text('Error: ${state.message}'));
        } else {
          return const Center(child: Text('Unknown state'));
        }
      },
    );
  }
}
