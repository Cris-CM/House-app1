import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

class HomeController extends GetxController {
  late stt.SpeechToText speech;
  RxBool isListening = false.obs;
  RxString text = "Toca el micrófono y habla...".obs;

  @override
  void onInit() {
    super.onInit();
    speech = stt.SpeechToText();
  }

  Future<void> listen() async {
    if (!isListening.value) {
      bool available = await speech.initialize(
        onStatus: (val) => debugPrint("✅ Estado: $val"),
        onError: (val) => debugPrint("❌ Error: $val"),
      );
      debugPrint("¿Disponible? $available");
      if (available) {
        isListening.value = true;
        speech.listen(
          localeId: "es-419",
          onResult: (val) {
            text.value = val.recognizedWords;
          },
        );
      } else {
        text.value = "Reconocimiento de voz no disponible en este dispositivo";
      }
    } else {
      isListening.value = false;
      speech.stop();
    }
  }

  var selectedTab = 0.obs;
}

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HomeController());
  }
}
