# AI Profanity TextField 🛡️

A smart, AI-powered Flutter text field widget that filters profanity in real-time using Gemini API! Keep your app's content clean and friendly in any language! ✨

![ai_profanity](https://github.com/user-attachments/assets/31bb2eb8-ad95-4af6-b483-6307f9a18375)



## Features 🌟

- 🌍 Multilingual profanity detection for ALL languages
- 🤖 AI-powered profanity detection using Gemini
- ✅ Custom validators support
- ⚡ Real-time validation while typing
- 🎨 Fully customizable appearance
- 🔄 Loading indicators and validation states
- ❌ Custom error messages
- ✅ Success indicators
- 🕒 Debounce support for optimal performance



## Language Support 🌐

Thanks to Gemini's powerful AI capabilities, our widget can detect profanity in:
- English 🇺🇸
- Spanish 🇪🇸
- French 🇫🇷
- German 🇩🇪
- Turkish 🇹🇷
- Chinese 🇨🇳
- Japanese 🇯🇵
- Korean 🇰🇷
- Arabic 🇸🇦
- Russian 🇷🇺
- ...and many more! 

The AI model understands context and cultural nuances in each language, ensuring accurate profanity detection worldwide! 🌎


## Getting Started 🚀

### Installation

Add this to your `pubspec.yaml`:

```yaml
dependencies:
  ai_profanity_textfield: ^1.0.0
```
### Get Your API Key

1. Visit [Google AI Studio](https://makersuite.google.com/app/apikey)
2. Sign in with your Google account
3. Click "Create API Key"
4. Copy your API key

### Quick Start 🏃

```dart
ProfanityTextFormField(
  geminiService: geminiService, // Your Gemini service instance
  decoration: InputDecoration(
    hintText: 'Enter text here...',
  ),
  onProfanityDetected: (text) {
    print('Profanity detected in: $text');
  },
)
```

## Custom Validators ✨

Add your own validation rules alongside AI profanity detection!

```dart
ProfanityTextFormField(
  geminiService: geminiService,
  checkWhileTyping: true,
  debounceDuration: const Duration(milliseconds: 500),
  validators: [
    (value) => value.isEmpty ? 'Required field' : null,
    (value) => value.length < 3 ? 'Too short' : null,
    (value) => !value.contains('@') ? 'Must contain @' : null,
  ],
  onProfanityDetected: (text) => print('Profanity detected!'),
  onCleanText: (text) => print('Text is clean and valid'),
  decoration: InputDecoration(
    hintText: 'Type something...',
    fillColor: Colors.white,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(18),
    ),
  ),
  showValidIcon: true,
  profanityMessage: 'Oops! Let\'s keep it friendly 😊',
  validationMessageDuration: const Duration(seconds: 3),
)
```


### Validation Process 🔄

1. Custom validators run first in the order they are defined
2. If all custom validations pass, AI profanity check runs
3. Text is considered valid only when both custom validations and profanity check pass

### Multilingual Example 🌐

```dart
ProfanityTextFormField(
  geminiService: geminiService,
  decoration: InputDecoration(
    hintText: '여기에 텍스트를 입력하세요...', // Korean
    // or '在此输入文字...' // Chinese
    // or 'Écrivez ici...' // French
    // etc.
  ),
  profanityMessage: 'Lütfen nazik olalım! 😊', // Turkish
  validators: [
    // Custom validators work with any language!
    (value) {
      if (value.length < 5) {
        return '最小5文字必要です'; // Japanese error message
      }
      return null;
    },
  ],
)
```

## Advanced Features 🔧

### Real-time Validation ⚡

The widget validates text as users type, with a customizable debounce duration:

```dart
ProfanityTextFormField(
  geminiService: geminiService,
  checkWhileTyping: true,
  debounceDuration: Duration(milliseconds: 500),
  validators: [
    // Custom validators run in real-time too!
    (value) => value.length < 3 ? 'Too short!' : null,
  ],
  onCleanText: (text) {
    print('Text is clean and valid: $text');
  },
)
```

### Custom Styling 🎨

Make it match your app's theme:

```dart
ProfanityTextFormField(
  geminiService: geminiService,
  successDecoration: InputDecoration(
    fillColor: Colors.green,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(18),
    ),
  ),
  profanityDecoration: InputDecoration(
    fillColor: Colors.red,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(18),
    ),
  ),
  progressIndicatorColor: Colors.blue,
  progressIndicatorSize: 20,
)
```


### Validation States 🚦

The widget provides different states with customizable appearances:
- ⏳ Loading
- ✅ Valid (all custom validators and profanity check passed)
- ❌ Invalid
- 🆕 Initial

### Error Handling 🚫

Custom error messages and handlers in any language:

```dart
ProfanityTextFormField(
  geminiService: geminiService,
  profanityMessage: 'Please keep it friendly! 😊',
  validators: [
    (value) => value.isEmpty ? 'Field cannot be empty!' : null,
  ],
  onError: (error) {
    print('Error occurred: $error');
  },
  clearOnProfanity: true,
)
```



## Properties 📋

| Property | Type | Description |
|----------|------|-------------|
| `geminiService` | `GeminiService` | Required. Your Gemini API service instance |
| `validators` | `List<FormFieldValidator<String>>?` | Custom validation rules |
| `checkWhileTyping` | `bool` | Enable/disable real-time validation |
| `debounceDuration` | `Duration` | Delay before validation triggers |
| `onProfanityDetected` | `Function(String)?` | Callback when profanity is found |
| `onCleanText` | `Function(String)?` | Callback when text is clean and valid |
| `clearOnProfanity` | `bool` | Clear field when profanity detected |
| `showValidIcon` | `bool` | Show/hide validation icons |
| `profanityMessage` | `String` | Custom error message (supports all languages) |




## Examples 📝

### Username Field

```dart
ProfanityTextFormField(
  geminiService: geminiService,
  decoration: InputDecoration(
    labelText: 'Username',
    prefixIcon: Icon(Icons.person),
  ),
  validators: [
    (value) => value.length < 3 ? 'Username too short' : null,
    (value) => value.contains(' ') ? 'No spaces allowed' : null,
  ],
)
```

### Comment Field

```dart
ProfanityTextFormField(
  geminiService: geminiService,
  decoration: InputDecoration(
    labelText: 'Comment',
    hintText: 'Share your thoughts...',
  ),
  maxLines: 3,
  clearOnProfanity: true,
  profanityMessage: 'Please keep comments friendly!',
)
```

### Search Field

```dart
ProfanityTextFormField(
  geminiService: geminiService,
  decoration: InputDecoration(
    labelText: 'Search',
    prefixIcon: Icon(Icons.search),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(30),
    ),
  ),
  debounceDuration: Duration(milliseconds: 300),
)
```

## Contributing 🤝

We welcome contributions! Please see our [Contributing Guide](CONTRIBUTING.md) for details.

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## License 📄

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

---

## Support 💪

If you like this package, please give it a ⭐️ on [GitHub](https://github.com/yourusername/ai_profanity_textfield)!

For bugs or feature requests, please [create an issue](https://github.com/yourusername/ai_profanity_textfield/issues).
