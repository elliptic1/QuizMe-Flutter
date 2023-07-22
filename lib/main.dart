// main.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'blocs/mic/MicState.dart';
import 'blocs/mic/MicText.dart';
import 'blocs/mic/MicCubit.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'QuizMe',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BlocProvider(
        create: (context) => MicCubit(),
        child: const MyHomePage(title: 'QuizMe Home Page'),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: const MicText(),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.read<MicCubit>().startRecording(),
        tooltip: 'Speak',
        child: const Icon(Icons.mic),
      ),
    );
  }
}
