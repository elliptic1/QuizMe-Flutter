import 'package:audioplayers/audioplayers.dart';

Future<void> playAudioFromLocalStorage(String filePath) async {
  AudioPlayer audioPlayer = AudioPlayer();
  await audioPlayer.play(DeviceFileSource(filePath));
}
