import 'package:ai_profanity_textfield/profanity.dart';
import 'package:flutter/material.dart';
import 'package:ai_profanity_textfield/src/profanity_widget.dart';

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
      debugShowCheckedModeBanner: false,
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
  late final GeminiService geminiService;

  @override
  void initState() {
    geminiService =
        GeminiService(apiKey: 'YOUR_GEMINI_API_KEY');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Profanity Example'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              ProfanityTextField(
                geminiService: geminiService,
                profanityDecoration:  InputDecoration(
                  errorText: 'Inappropriate content detected',
                  errorStyle: TextStyle(color: Colors.red),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.blue),
                  ),
                ),
                decoration: InputDecoration(
                  labelText: 'Name',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: Colors.blue),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
