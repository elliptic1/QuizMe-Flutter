

import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:flutter/material.dart';

class VoiceDropdown extends StatefulWidget {
  @override
  _VoiceDropdownState createState() => _VoiceDropdownState();
}

class _VoiceDropdownState extends State<VoiceDropdown> {
  String? _chosenValue;
  List<dynamic> voices = [];

  void fetchVoices() async {
    final response = await http.get(Uri.parse('https://api.elevenlabs.io/v1/voices'));

    if (response.statusCode == 200) {
      setState(() {
        voices = json.decode(response.body);
      });
    } else {
      throw Exception('Failed to load voices');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchVoices();
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: _chosenValue,
      items: voices.map<DropdownMenuItem<String>>((voice) {
        return DropdownMenuItem<String>(
          value: voice['voice_id'],
          child: Text(voice['name']),
        );
      }).toList(),
      onChanged: (String? value) {
        setState(() {
          _chosenValue = value;
        });
      },
    );
  }
}