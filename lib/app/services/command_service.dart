import 'package:dio/dio.dart';

class CommandService {
  final Dio dio;

  CommandService(this.dio);

  Future<void> sendCommand(String command) async {
    try {
      final response = await dio.post("/command", data: {"text": command});
      return response.data;
    } catch (e) {
      rethrow;
    }
  }
}
