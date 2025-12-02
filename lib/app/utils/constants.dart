import 'package:flutter/foundation.dart';

class Constants {
  static const String baseUrl = kDebugMode
      ? "http://192.168.0.102:3000/"
      : "https://house-api-murex.vercel.app/";
}
