import 'package:dart_openai/dart_openai.dart';

// Set the OpenAI API key.
void setOpenAIAPIKey() {
  OpenAI.apiKey = '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';
}

const String instructions = """
Pretend that you are interviewing me for a job at Google. 
Ask me questions about Android, kotlin coroutines, jetpack Compose, 
computer science, algorithms, and about being a lead android software 
engineer. Grade my response out of ten. Repeat the question if i need it. 
Ask a new question when I've answered it well enough. Ask one question at 
a time, evaluate my response, and help me improve my answers.""";

Future<String> getOpenAIResponse(String text) async {
  var completion = await OpenAI.instance.completion.create(
    model: 'text-davinci-003',
    prompt: "$instructions - $text",
  );

  return completion.choices.first.text;
}
