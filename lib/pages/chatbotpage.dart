import 'dart:async';

import 'package:edi/chatbot/chatmessages.dart';
import 'package:flutter/material.dart';
import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';
import 'package:velocity_x/velocity_x.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _messagecontroller = TextEditingController();
  final List<ChatMessages> _messages = [];
  late OpenAI chatGPT;

  @override
  void initState() {
    chatGPT = OpenAI.instance.build(
      token: "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",
    );
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void sendmessage() async {
    ChatMessages _message = ChatMessages(
        text: _messagecontroller.text, sender: "user", isImage: false);

    setState(() {
      _messages.insert(0, _message);
    });

    _messagecontroller.clear();
    final request = CompleteText(
        prompt: _message.text, model: TextDavinci3Model(), maxTokens: 200);
    //     ChatCompleteText(messages: [
    //   Messages(role: Role.assistant, content: 'Hello!'),
    // ], model: GptTurbo0631Model());
    //final request = CompleteText(prompt: _message.text, model: Gpt4ChatModel(),maxTokens: 200);
    final response = await chatGPT.onCompletion(request: request);
    print(response);
    // Vx.log(response!.choices[0].toString());
    Vx.log(response!.choices[0].text);
    insertNewData(response.choices[0].text);
  }

  void insertNewData(String response) {
    ChatMessages resp = ChatMessages(
      text: response,
      sender: "bot",
      isImage: false,
    );
    setState(() {
      _messages.insert(0, resp);
    });
  }

  Widget textComposer() {
    return Row(
      children: [
        Padding(padding: EdgeInsets.all(6)),
        Expanded(
            child: TextField(
          onSubmitted: (value) => sendmessage(),
          decoration: InputDecoration.collapsed(hintText: 'Ask a question...'),
          controller: _messagecontroller,
        )),
        IconButton(onPressed: () => sendmessage(), icon: Icon(Icons.send))
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints.expand(),
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage('assets/images/bgcolor.png'), fit: BoxFit.fill),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.grey[900],
          title: Title(color: Colors.white, child: Text("FinanceBot")),
          centerTitle: true,
        ),
        body: Column(
          children: [
            Flexible(
              child: ListView.builder(
                reverse: true,
                padding: const EdgeInsets.all(8),
                itemCount: _messages.length,
                itemBuilder: (BuildContext context, int index) {
                  return _messages[index];
                },
              ),
            ),
            Container(
                decoration: BoxDecoration(color: Colors.white),
                child: textComposer()),
            Container(
              height: 20,
              color: Colors.white,
            )
          ],
        ),
      ),
    );
  }
}
