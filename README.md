# AI Profanity TextField 🛡️

A smart, AI-powered Flutter text field widget that filters profanity in real-time using Gemini API! Keep your app's content clean and friendly in any language! ✨

## Features 🌟

- 🌍 Multilingual profanity detection for ALL languages
- 🤖 AI-powered profanity detection using Gemini
- ⚡ Real-time validation while typing
- 🎨 Fully customizable appearance
- 🔄 Loading indicators and validation states
- ❌ Custom error messages
- ✅ Success indicators
- 🕒 Debounce support for optimal performance


  ![ai_profanity](https://github.com/user-attachments/assets/c04a8139-8847-453f-b3f3-2093365e678c)
  

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

### Basic Usage 💻

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
  // or '友好的な言葉を使いましょう！' // Japanese
  // or 'يرجى الحفاظ على لطفك!' // Arabic
  onProfanityDetected: (text) {
    print('Inappropriate content detected');
  },
)
```

[Insert GIF showing basic usage example]

## Advanced Features 🔧

### Real-time Validation ⚡

The widget validates text as users type, with a customizable debounce duration:

```dart
ProfanityTextFormField(
  geminiService: geminiService,
  checkWhileTyping: true,
  debounceDuration: Duration(milliseconds: 500),
  onCleanText: (text) {
    print('Text is clean: $text');
  },
)
```

### Custom Styling 🎨

Make it match your app's theme:

```dart
ProfanityTextFormField(
  geminiService: geminiService,
  decoration: InputDecoration(
    fillColor: Colors.grey[200],
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(18),
    ),
  ),
  progressIndicatorColor: Colors.blue,
  progressIndicatorSize: 20,
)
```

[Insert GIF showing different styling options]

### Validation States 🚦

The widget provides different states with customizable appearances:
- ⏳ Loading
- ✅ Valid
- ❌ Invalid
- 🆕 Initial

### Error Handling 🚫

Custom error messages and handlers in any language:

```dart
ProfanityTextFormField(
  geminiService: geminiService,
  profanityMessage: 'Please keep it friendly! 😊',
  // or '¡Mantengámoslo amistoso!' (Spanish)
  // or 'Bleib freundlich!' (German)
  onError: (error) {
    print('Error occurred: $error');
  },
  clearOnProfanity: true,
)
```

## Complete Example 📝

```dart
ProfanityTextFormField(
  geminiService: geminiService,
  checkWhileTyping: true,
  debounceDuration: const Duration(milliseconds: 500),
  onProfanityDetected: (text) => print('Profanity detected!'),
  onCleanText: (text) => print('Text is clean'),
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

## Properties 📋

| Property | Type | Description |
|----------|------|-------------|
| `geminiService` | `GeminiService` | Required. Your Gemini API service instance |
| `checkWhileTyping` | `bool` | Enable/disable real-time validation |
| `debounceDuration` | `Duration` | Delay before validation triggers |
| `onProfanityDetected` | `Function(String)?` | Callback when profanity is found |
| `onCleanText` | `Function(String)?` | Callback when text is clean |
| `clearOnProfanity` | `bool` | Clear field when profanity detected |
| `showValidIcon` | `bool` | Show/hide validation icons |
| `profanityMessage` | `String` | Custom error message (supports all languages) |

## Contributing 🤝

Contributions are welcome! Feel free to submit issues and pull requests.

## License 📄

This project is licensed under the MIT License - see the LICENSE file for details.
