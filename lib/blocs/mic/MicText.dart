// mic_text.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'MicState.dart';
import 'MicCubit.dart';

class MicText extends StatelessWidget {
  const MicText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MicCubit, MicState>(
      builder: (context, state) {
        if (state is MicRecording) {
          return const Center(child: Text('Listening...'));
        } else {
          return const Center(
              child: Text('Press the microphone button to start speaking'));
        }
      },
    );
  }
}
