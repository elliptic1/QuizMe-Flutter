import 'package:flutter/cupertino.dart';

import '../elevenlabs/send_text.dart';
import '../openai/setApiKey.dart';
import '../openai/utils.dart';

class InterviewInitWidget extends StatefulWidget {
  const InterviewInitWidget({super.key});

  @override
  MyWidgetState createState() => MyWidgetState();
}

class MyWidgetState extends State<InterviewInitWidget> {
  @override
  void initState() {
    super.initState();
    setOpenAIAPIKey();
    getOpenAIResponse(
        "Let's start the interview. First please ask me which company and job title I would like to interview for.")
        .then((String response) {
      sendRequestAndPlayAudio(response, "cPH0XQN52gtqbMOQoFS3");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
