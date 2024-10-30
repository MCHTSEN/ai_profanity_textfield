import 'package:example/decorated/decorated_example.dart';
import 'package:flutter/material.dart';
import 'package:ai_profanity_textfield/profanity.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AI Profanity TextField Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        primaryColor: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _formKey = GlobalKey<FormState>();
  // Initialize your GeminiService here
  final geminiService = GeminiService(apiKey: 'YOUR_API_KEY');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AI Profanity TextField Example'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // Basic usage
              ProfanityTextFormField(
                geminiService: geminiService,
                decoration: const InputDecoration(
                  labelText: 'Basic Example',
                  hintText: 'Type something...',
                ),
              ),
              const SizedBox(height: 20),
              // Advanced usage with callbacks
              ProfanityTextFormField(
                geminiService: geminiService,
                debounceDuration: const Duration(milliseconds: 500),
                profanityMessage:
                    'Oops! Try a friendlier username.', // Custom message in Turkish
                decoration: const InputDecoration(
                  labelText: 'Advanced Example',
                  hintText: 'Type something...',
                ),
                onProfanityDetected: (text) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Profanity detected in: $text'),
                      backgroundColor: Colors.red,
                    ),
                  );
                },
                onCleanText: (text) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Text is clean!'),
                      backgroundColor: Colors.green,
                    ),
                  );
                },
                validators: [
                  (value) {
                    if (value != null && value.length < 3) {
                      return 'Text must be at least 3 characters long';
                    }
                    return null;
                  },

                  (value) {
                    if (value != null && !RegExp(r'\d').hasMatch(value)) {
                      return 'Text must contain at least one number';
                    }
                    return null;
                  }


                ],

                // clear text field when profanity is detected
                clearOnProfanity: false,
                // show an icon that indicates valid or invalid
                showValidIcon: true,
              ),

              const SizedBox(height: 20),

              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Form is valid!')),
                    );
                  }
                },
                child: const Text('Validate Form'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
