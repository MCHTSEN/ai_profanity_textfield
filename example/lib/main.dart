import 'package:ai_profanity_textfield/gemini_service.dart';
import 'package:ai_profanity_textfield/profanity_textfield.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Profanity Example',
      home: ProfanityExample(),
    );
  }
}

class ProfanityExample extends StatefulWidget {
  const ProfanityExample({super.key});

  @override
  State<ProfanityExample> createState() => _ProfanityExampleState();
}

class _ProfanityExampleState extends State<ProfanityExample> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
         
        ],
      )
    );
  }
}
