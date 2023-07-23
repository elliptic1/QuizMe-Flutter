import 'package:path_provider/path_provider.dart';
import 'dart:io';

import '../../blocs/mic/MicState.dart';

class AudioFileManager {

  Future<String> get filePath async {
    final file = await _localFile;
    return file.path;
  }

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/recording.aac');
  }

  Future<File> createFile() async {
    final file = await _localFile;
    return file.create();
  }

  Future<String> checkFilePath() async {
    try {
      final file = await createFile();
      return 'File created at: ${file.path}';
    } catch (error) {
      throw MicError('Failed to create file: $error');
    }
  }
}
