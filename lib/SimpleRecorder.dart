import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';

class SimpleRecorder extends StatefulWidget {
  const SimpleRecorder({super.key});

  @override
  SimpleRecorderState createState() => SimpleRecorderState();
}

class SimpleRecorderState extends State<SimpleRecorder> {
  FlutterSoundRecorder? _recorder;
  bool _isRecording = false;

  @override
  void initState() {
    super.initState();
    _recorder = FlutterSoundRecorder();
    _init();
  }

  Future<void> _init() async {
    await _recorder!.openRecorder();
  }

  @override
  void dispose() {
    _recorder!.closeRecorder();
    _recorder = null;
    super.dispose();
  }

  Future<void> _startRecording() async {
    await _recorder!.startRecorder(toFile: 'path_to_your_file');
    setState(() {
      _isRecording = true;
    });
  }

  Future<void> _stopRecording() async {
    await _recorder!.stopRecorder();
    setState(() {
      _isRecording = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Simple Recorder')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('Press the button to start recording'),
            IconButton(
              onPressed: _isRecording ? _stopRecording : _startRecording,
              icon: Icon(_isRecording ? Icons.stop : Icons.mic),
            ),
          ],
        ),
      ),
    );
  }
}
