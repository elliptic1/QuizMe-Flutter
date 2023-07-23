import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz_me/blocs/mic/MicState.dart';

import '../../blocs/mic/MicCubit.dart';

class MicFAB extends StatelessWidget {
  const MicFAB({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    Widget fab(IconData icon, VoidCallback onPressed,
        {MaterialColor backgroundColor = Colors.grey}) {
      return SizedBox(
        height: 150.0, // Set the desired height
        width: 150.0, // Set the desired width
        child: FittedBox(
          child: FloatingActionButton(
            onPressed: onPressed,
            backgroundColor: backgroundColor,
            child: Icon(
              icon,
              size: 40.0, // Adjust the icon size to fit the new FAB size
            ),
          ),
        ),
      );
    }

    return BlocBuilder<MicCubit, MicState>(
      builder: (context, state) {
        log("FAB state: $state");
        if (state is MicIdle) {
          return fab(Icons.mic, () {
            context.read<MicCubit>().startRecording();
          }, backgroundColor: Colors.blue);
        } else if (state is MicRecording) {
          return fab(Icons.record_voice_over, () {
            context.read<MicCubit>().stopRecording();
          }, backgroundColor: Colors.red);
        } else if (state is MicError) {
          return fab(Icons.mic_none, () {
            context.read<MicCubit>().startRecording();
          }, backgroundColor: Colors.grey);
        } else {
          return fab(Icons.error, () {
            context.read<MicCubit>().stopRecording();
          }, backgroundColor: Colors.grey);
        }
      },
    );
  }
}
