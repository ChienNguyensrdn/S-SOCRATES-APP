import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart';

class VoicePanel extends StatefulWidget {

  final Function(String) onSpeech;

  const VoicePanel({super.key, required this.onSpeech});

  @override
  State<VoicePanel> createState() => _VoicePanelState();
}

class _VoicePanelState extends State<VoicePanel>
    with SingleTickerProviderStateMixin {

  late AnimationController controller;
  final SpeechToText speech = SpeechToText();

  bool listening = false;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    )..repeat(reverse: true);
  }

  void startListening() async {

    bool available = await speech.initialize();

    if (available) {
      setState(() => listening = true);

      speech.listen(onResult: (result) {
        if (result.finalResult) {
          widget.onSpeech(result.recognizedWords);
          setState(() => listening = false);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {

    return Container(
      height: 120,
      color: Colors.white,

      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [

          IconButton(
            iconSize: 50,
            icon: const Icon(Icons.mic),
            onPressed: startListening,
          ),

          const SizedBox(height: 10),

          if (listening)
            AnimatedBuilder(
              animation: controller,
              builder: (context, child) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    20,
                    (index) {

                      double height =
                          (controller.value * 30) + 10;

                      return Container(
                        width: 4,
                        height: height,
                        margin: const EdgeInsets.symmetric(horizontal: 2),
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(2),
                        ),
                      );
                    },
                  ),
                );
              },
            )
          else
            const Text("Tap microphone to speak"),
        ],
      ),
    );
  }
}