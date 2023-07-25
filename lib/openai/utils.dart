import 'package:dart_openai/dart_openai.dart';
import 'package:flutter/cupertino.dart';

const String instructions = """
You are a helpful assistant who is pretending to interview me.
Ask me one question at a time. 
Keep your responses professional. Be strict in evaluating my response, but also help me make it better.
Begin the mock interview now.
""";

List<OpenAIChatCompletionChoiceMessageModel> messages = [
  const OpenAIChatCompletionChoiceMessageModel(role: OpenAIChatMessageRole.system, content: instructions),
];

Future<String> getOpenAIResponse(String text) async {
  // Add the user's message to the messages list
  messages.add(OpenAIChatCompletionChoiceMessageModel(role: OpenAIChatMessageRole.user, content: text));

  debugPrint("Sending message: $text");

  // Use the chat.create method instead of completion.create
  var chatCompletion = await OpenAI.instance.chat.create(
    model: 'gpt-4-0613',  // Use the chat model
    messages: messages,
    maxTokens: 500,
  );

  var assistantMessage = chatCompletion.choices[0].message.content;

  debugPrint("Response: $assistantMessage");

  // Add the assistant's message to the messages list
  messages.add(OpenAIChatCompletionChoiceMessageModel(role: OpenAIChatMessageRole.assistant, content: assistantMessage));

  return assistantMessage;
}
