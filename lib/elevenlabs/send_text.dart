

import 'dart:io';
import 'dart:convert';
import 'package:audioplayers/audioplayers.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import '../openai/setApiKey.dart';
import 'audio.dart';


Future<void> sendRequestAndPlayAudio(String text, String voiceId) async {
  const String xiApiKey = elevenLabsAPIKey;
  final String ttsUrl = 'https://api.elevenlabs.io/v1/text-to-speech/$voiceId/stream';
  final Map<String, String> headers = {
    'Accept': 'application/json',
    'Content-Type': 'application/json',
    'xi-api-key': xiApiKey,
  };
  final Map<String, dynamic> data = {
    'text': text,
    'model_id': 'eleven_monolingual_v1',
    'voice_settings': {
      'stability': 0.5,
      'similarity_boost': 0.5,
    },
  };
  final http.Response response = await http.post(
    Uri.parse(ttsUrl),
    headers: headers,
    body: jsonEncode(data),
  );
  if (response.statusCode == 200) {
    final Directory tempDir = await getTemporaryDirectory();
    final File tempFile = File('${tempDir.path}/temp.mp3');
    await tempFile.writeAsBytes(response.bodyBytes);
    await playAudioFromLocalStorage(tempFile.path);
  } else {
    // error
  }
}

