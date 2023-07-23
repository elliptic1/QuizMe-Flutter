import 'package:dart_openai/dart_openai.dart';
import 'package:flutter/cupertino.dart';

// Set the OpenAI API key.
void setOpenAIAPIKey() {
  OpenAI.apiKey = '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';
}

const String instructions = """
You are interviewing me for a job at Google. 
Ask me questions about Android, kotlin coroutines, jetpack Compose, 
computer science, algorithms, and about being a lead android software 
engineer.  
Ask me one question at a time. 
Wait for my response in the next prompt. 
""";

String lastResponse = "";

Future<String> getOpenAIResponse(String text) async {
  var prompt = instructions;
  if (lastResponse.isNotEmpty) {
    prompt += """
    The last response you gave me is: ($lastResponse). 
    Now that you have the context of our conversation, I will respond with this: 
    My Answer: [$text].
    Evaluate my response. If I've tried to answer the question again then suggest ways to improve my answer.
    If I've asked for a new question or if I did a good job on the previous answer, then ask a new question.
    """;
  }


  debugPrint("Sending prompt: $prompt");
  var completion = await OpenAI.instance.completion.create(
    model: 'text-davinci-003',
    prompt: prompt,
    maxTokens: 400,
  );

  lastResponse = completion.choices.first.text;

  debugPrint("Response: $lastResponse ---");

  return lastResponse;
}

