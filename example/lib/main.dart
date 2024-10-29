import 'package:ai_profanity_textfield/profanity.dart';
import 'package:flutter/material.dart';
import 'package:ai_profanity_textfield/src/profanity_widget.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
  final _formKey = GlobalKey<FormState>();
  late final GeminiService geminiService;

  @override
  void initState() {
    geminiService =
        GeminiService(apiKey: 'AIzaSyCmgv7RAHTpybOw1k2WyxG9PaFyQmgNU_M');

    super.initState();
  }

  void _submitForm() {
    if (_formKey.currentState?.validate() ?? false) {
      // Form is valid
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Form Submitted Successfully')),
      );
    } else {
      // Form is invalid
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fix the errors in the form')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Profanity Example'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                ProfanityTextFormField(
                  validators: [
                    //add a validator here
                    (value) {
                      if (value == null || value.isEmpty) {
                        return 'This field is required';
                      }
                      return null;
                    },
                    (value) {
                      if (value!.length < 6) {
                        return 'Password must be at least 6 characters';
                      }
                      return null;
                    },
                    (value) {
                      if (!value!.contains(RegExp(r'\d'))) {
                        return 'Password must contain at least one number';
                      }
                      return null;
                    },
                  ],
                  geminiService: geminiService,
                  profanityDecoration: InputDecoration(
                    errorText: 'Inappropriate content detected',
                    errorStyle: const TextStyle(color: Colors.red),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Colors.blue),
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
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _submitForm,
                  child: const Text('Submit'),
                ),
              ],
            ),
          ),
        ));
  }
}
