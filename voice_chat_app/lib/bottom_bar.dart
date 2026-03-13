import 'package:flutter/material.dart';

class BottomBar extends StatelessWidget {
  const BottomBar({super.key});

  @override
  Widget build(BuildContext context) {

    return Container(
      margin: const EdgeInsets.all(20),
      height: 70,

      decoration: BoxDecoration(
        color: Colors.black26,
        borderRadius: BorderRadius.circular(40),
      ),

      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,

        children: const [

          Icon(Icons.description, color: Colors.white),

          CircleAvatar(
            radius: 28,
            backgroundColor: Colors.purpleAccent,
            child: Icon(Icons.mic, color: Colors.white),
          ),

          Icon(Icons.person, color: Colors.white),

        ],
      ),
    );
  }
}