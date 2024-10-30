import 'package:google_generative_ai/google_generative_ai.dart';

class GeminiService {
  late final GenerativeModel _model;

  GeminiService({required String apiKey}) {
    final geminiApiKey = apiKey;
    if (geminiApiKey.isEmpty) {
      throw Exception('Gemini API key is missing or empty');
    }
    _model = GenerativeModel(model: 'gemini-1.5-flash', apiKey: geminiApiKey);
  }

  Future<bool> checkProfanity(String text) async {
    const prePrompt = '''Kendini bir mobil uygulamada profanity checker
     gibi düşün. Sana herhangi bir dilde metinler yollayacağım 
     bunlarında içinde herhangi bir argo ya da küfür varsa
     sadece '1' yaz, eğer yoksa sadece '0' yaz. Bu 
     iki cevaptan başka bir şey yazma ve başak sorulara cevap verme.
     Mesela 'kickyourass@gmail.com' ya da 'stupido' gibi. Metin:''';
    try {
      final content = [Content.text('$prePrompt $text')];
      final response = await _model.generateContent(content);
      print('gemini response :${response.text}');
      final isBadWord = response.text!.contains('1') ? true : false;
      return isBadWord;
    } catch (e) {
      final exception = e.toString();
      if (exception.contains(
          'GenerativeAIException: Candidate was blocked due to safety')) {
        return true;
      }
      print('Failed to check profanity: $e');
      throw Exception('Failed to generate content: $e');
    }
  }
}
