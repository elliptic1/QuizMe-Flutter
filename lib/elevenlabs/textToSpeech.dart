
import 'dart:io';
import 'dart:convert';
import 'package:audioplayers/audioplayers.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import '../openai/setApiKey.dart';


Future<void> textToSpeech(String text) async {
  const String XI_API_KEY = elevenLabsAPIKey;
  const String voiceId = "<voice-id>"; // Replace with your voice ID
  const String ttsUrl = "https://api.elevenlabs.io/v1/text-to-speech/$voiceId/stream";

  final Map<String, String> headers = {
    "Accept": "application/json",
    "xi-api-key": XI_API_KEY,
    "Content-Type": "application/json",
  };

  final Map<String, dynamic> data = {
    "text": text,
    "model_id": "eleven_monolingual_v1",
    "voice_settings": {
      "stability": 0.5, // Replace with your stability value
      "similarity_boost": 0.5, // Replace with your similarity_boost value
    },
  };

  final response = await http.post(
    Uri.parse(ttsUrl),
    headers: headers,
    body: jsonEncode(data),
  );

  if (response.statusCode == 200) {
    // The request was successful. You can save the audio file here.
    const String outputPath = "<path-to-file>";
    final File file = File(outputPath);
    await file.writeAsBytes(response.bodyBytes);
  } else {
    // The request failed. Handle the error.
    print('Request failed with status: ${response.statusCode}.');
  }
}


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
    final AudioPlayer audioPlayer = AudioPlayer();

    await audioPlayer.play(DeviceFileSource(tempFile.path));
  } else {
    // error
  }
}

Future<void> playAudioFromLocalStorage(String filePath) async {
  AudioPlayer audioPlayer = AudioPlayer();
  await audioPlayer.play(DeviceFileSource(filePath));
}
