import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:house_app/app/blocs/home_bloc/home_bloc.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late stt.SpeechToText _speech;
  bool _isListening = false;
  String _text = "Toca el micrófono y habla...";

  @override
  void initState() {
    super.initState();
    _speech = stt.SpeechToText();
  }

  Future<void> _listen() async {
    if (!_isListening) {
      bool available = await _speech.initialize(
        onStatus: (val) => debugPrint("✅ Estado: $val"),
        onError: (val) => debugPrint("❌ Error: $val"),
      );
      debugPrint("¿Disponible? $available");
      if (available) {
        setState(() => _isListening = true);
        _speech.listen(
          localeId: "es-419",
          onResult: (val) {
            setState(() {
              _text = val.recognizedWords;
              context.read<HomeBloc>().add(
                HomeEventSendCommand(val.recognizedWords),
              );
            });
          },
        );
      } else {
        setState(() {
          _text = "Reconocimiento de voz no disponible en este dispositivo";
        });
      }
    } else {
      setState(() => _isListening = false);
      _speech.stop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Spacer(),
            GestureDetector(
              onTap: _listen,
              child: Container(
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                  color: _isListening ? Colors.red : Colors.green,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 8,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: Icon(
                  _isListening ? Icons.mic : Icons.mic_none,
                  size: 50,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 20),

            Text(
              _isListening ? "🎤 Escuchando..." : "Presiona para hablar",
              style: const TextStyle(fontSize: 16, color: Colors.grey),
            ),
            Spacer(),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 8,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Text(
                _text,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {},
                    child: const Text(
                      "Prender Luz de Habitación",
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {},
                    child: const Text(
                      "Apagar Luz de Habitación",
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
