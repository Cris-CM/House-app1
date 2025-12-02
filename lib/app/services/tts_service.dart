import 'package:flutter_tts/flutter_tts.dart';

class TTSService {
  final FlutterTts tts = FlutterTts();

  Future<void> speak(String text) async {
    await tts.setLanguage("es-ES"); // Español
    await tts.setPitch(1); // Tono normal
    await tts.setSpeechRate(0.5); // Velocidad natural
    await tts.speak(text);
  }

  Future stop() async {
    await tts.stop();
  }
}
