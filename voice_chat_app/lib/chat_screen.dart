import 'package:flutter/material.dart';
import '../services/agent_api.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {

  final AgentAPI api = AgentAPI();

  List messages = [];

  final controller = TextEditingController();

  void sendMessage() async {

    String text = controller.text;

    setState(() {
      messages.add({"text": text, "user": true});
    });

    controller.clear();

    String reply = await api.sendMessage(text);

    setState(() {
      messages.add({"text": reply, "user": false});
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text("S-Socrates AI"),
      ),

      body: Column(
        children: [

          Expanded(
            child: ListView.builder(
              itemCount: messages.length,
              itemBuilder: (context,index){

                var msg = messages[index];

                return Align(
                  alignment: msg["user"]
                      ? Alignment.centerRight
                      : Alignment.centerLeft,

                  child: Container(
                    padding: const EdgeInsets.all(12),
                    margin: const EdgeInsets.all(8),

                    decoration: BoxDecoration(
                      color: msg["user"]
                          ? Colors.deepPurple
                          : Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(10),
                    ),

                    child: Text(msg["text"]),
                  ),
                );
              },
            ),
          ),

          Row(
            children: [

              Expanded(
                child: TextField(
                  controller: controller,
                  decoration: const InputDecoration(
                    hintText: "Hỏi S-Socrates..."
                  ),
                ),
              ),

              IconButton(
                icon: const Icon(Icons.send),
                onPressed: sendMessage,
              )

            ],
          )

        ],
      ),
    );
  }
}