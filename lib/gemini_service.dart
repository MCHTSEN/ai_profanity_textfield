import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

class GeminiService {
  late final GenerativeModel _model;

  GeminiService() {
    final apiKey = dotenv.env['GEMINI_API_KEY'];
    if (apiKey == null || apiKey.isEmpty) {
      throw Exception('Gemini API key is missing or empty');
    }
    _model = GenerativeModel(model: 'gemini-1.5-flash', apiKey: apiKey);
  }

  Future<String> generateContent(String text) async {
    // example text
    const String prePrompt = '''
    Kendini bir teknik servis danismani olarak hayal et. Teknik serviste calisan biri sana geliyor ve sana bir sorununu anlatiyor.
    Bu sorunu çözmek için birkac çözüm önerisi sunman gerekiyor. Bu sorunlarin neden kaynaklandigini da belirtmelisin.
    Musteriye soru sorma senin ile iletisime gecemez ve sana mesaj atamaz.
    Yazarken yardimci, anlayici ve sabirli olmalisin. Detaylari atlamamalisin. Turkce olarak yazmalisin. 
    Basliklari kalin punto ile yazma. Liste elemanlari icin '-' kullan.
    Şikayet şu şekilde:
''';
    try {
      final content = [Content.text('$prePrompt $text')];
      final response = await _model.generateContent(content);
      return response.text ?? '';
    } catch (e) {
      throw Exception('Failed to generate content: $e');
    }
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
      throw Exception('Failed to generate content: $e');
    }
  }
}
