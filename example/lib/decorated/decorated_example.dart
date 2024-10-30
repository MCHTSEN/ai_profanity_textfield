import 'package:ai_profanity_textfield/profanity.dart';
import 'package:example/decorated/textfield_wrapper.dart';
import 'package:flutter/material.dart';

class DecoratedExample extends StatefulWidget {
  const DecoratedExample({super.key});

  @override
  State<DecoratedExample> createState() => _DecoratedExampleState();
}

class _DecoratedExampleState extends State<DecoratedExample> {
  final _formKey = GlobalKey<FormState>();
  // Initialize your GeminiService here
  final geminiService =
      GeminiService(apiKey: 'AIzaSyCEHocpiyvbc3Lc4mB1PYdNyKQtH9B6Scc');

  @override
  Widget build(BuildContext context) {
    return BaseBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: const Text(
            'AI Profanity Textfield',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Basic usage
                const Text(
                  'USERNAME',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                // Advanced usage with callbacks
                ProfanityTextFormField(
                  geminiService: geminiService,
                  debounceDuration: const Duration(milliseconds: 500),
                  profanityMessage:
                      'Oops! Try a friendlier username.', // Custom message in Turkish
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    fillColor: const Color(0xff282828),
                    hintText: 'Type something...',
                    hintStyle: const TextStyle(
                      color: Colors.grey,
                      fontSize: 14,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.transparent),
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  profanityDecoration: const InputDecoration(
                    border: InputBorder.none,
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

                // const SizedBox(height: 20),

                // ElevatedButton(
                //   onPressed: () {
                //     if (_formKey.currentState!.validate()) {
                //       ScaffoldMessenger.of(context).showSnackBar(
                //         const SnackBar(content: Text('Form is valid!')),
                //       );
                //     }
                //   },
                //   child: const Text('Validate Form'),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
