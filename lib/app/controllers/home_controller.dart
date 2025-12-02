import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:house_app/app/network/dio.dart';
import 'package:house_app/domain/models/device_model.dart';
import 'package:house_app/domain/models/room_model.dart';
import 'package:lottie/lottie.dart';
import 'package:sizer/sizer.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:house_app/app/services/tts_service.dart';
import 'package:house_app/app/services/command_service.dart';
import 'dart:async';

class HomeController extends GetxController {
  late stt.SpeechToText speech;
  RxBool isListening = false.obs;
  RxString text = "Toca el micrófono y habla...".obs;
  final TTSService ttsService = TTSService();
  final CommandService commandService = CommandService(dio);
  Timer? _silenceTimer;
  bool commandExecuted = false;
  RxBool isSetupPins = false.obs;
  final RxList<DeviceModel> devices = <DeviceModel>[].obs;
  final RxList<RoomModel> rooms = <RoomModel>[].obs;
  @override
  void onInit() {
    super.onInit();
    refreshData();
    speech = stt.SpeechToText();
  }

  Future<void> refreshData() async {
    rooms.clear();
    devices.clear();
    await commandService.getRooms().then((value) {
      rooms.value = value.data!;
    });
    await commandService.getDevices().then((value) {
      devices.value = value.data!;
    });
  }

  Future<void> _restartSilenceTimer() async {
    _silenceTimer?.cancel();

    _silenceTimer = Timer(const Duration(seconds: 2), () async {
      if (commandExecuted) return;
      commandExecuted = true;
      debugPrint("⏱️ 2 segundos sin hablar → ejecutando comando");

      isListening.value = false;
      speech.stop();

      final response = await commandService.sendCommand(text.value);
      if (response.respuesta != null) {
        await ttsService.speak(response.respuesta!);
        await refreshData();
      }
    });
  }

  Future<void> listen() async {
    if (!isListening.value) {
      commandExecuted = false;
      bool available = await speech.initialize(
        onError: (val) {
          debugPrint("Error: $val");
        },
      );

      if (available) {
        isListening.value = true;
        await speech.listen(
          localeId: "es-419",
          onResult: (val) async {
            text.value = val.recognizedWords;
            await _restartSilenceTimer();
          },
        );
      } else {
        text.value = "Reconocimiento de voz no disponible.";
      }
    } else {
      isListening.value = false;
      speech.stop();
      commandExecuted = false;
      _silenceTimer?.cancel();
      text.value = "Toca el micrófono y habla...";
    }
  }

  var selectedTab = 0.obs;

  void showLuaBottonSheet() async {
    await ttsService.speak("Hola, ¿en qué puedo ayudarte?");
    await Get.bottomSheet(
      Container(
        width: double.infinity,
        height: 50.h,
        padding: EdgeInsets.only(bottom: 5.h, left: 5.w, right: 5.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Align(
              alignment: Alignment.topRight,
              child: IconButton(
                onPressed: () => Get.back(),
                icon: const Icon(Icons.close),
              ),
            ),
            Text(
              "Hola, ¿en qué puedo ayudarte?",
              style: TextStyle(fontSize: 20.sp),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            Expanded(
              child: Lottie.asset(
                "assets/images/lua.lottie",
                decoder: customDecoder,
                width: 50.w,
                height: 50.w,
              ),
            ),
            Obx(
              () => IconButton.outlined(
                onPressed: listen,
                icon: Icon(
                  isListening.value ? Icons.mic : Icons.mic_off,
                  color: isListening.value ? Colors.purple : Colors.black,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Obx(() => Text(text.value, style: TextStyle(fontSize: 20.sp))),
          ],
        ),
      ),
      isDismissible: false,
    ).then((value) {
      isListening.value = false;
      speech.stop();
      _silenceTimer?.cancel();
      text.value = "Toca el micrófono y habla...";
    });
  }

  Future<LottieComposition?> customDecoder(List<int> bytes) {
    return LottieComposition.decodeZip(
      bytes,
      filePicker: (files) {
        return files.firstWhereOrNull(
          (f) => f.name.startsWith('animations/') && f.name.endsWith('.json'),
        );
      },
    );
  }

  Future<void> setupPins() async {
    try {
      final result = await commandService.setupPins();
      if (result) {
        isSetupPins.value = true;
        Get.snackbar(
          "Éxito",
          "Se han configurado los pines correctamente.",
          snackPosition: SnackPosition.TOP,
        );
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> changeLight(int deviceId, bool isOn) async {
    try {
      final result = await commandService.changeLight(deviceId, isOn);
      if (result != "error") {
        Get.snackbar(
          "Éxito",
          "Se ha cambiado el estado del dispositivo correctamente.",
          snackPosition: SnackPosition.TOP,
        );
        await refreshData();
      }
    } catch (e) {
      rethrow;
    }
  }
}

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HomeController());
  }
}
