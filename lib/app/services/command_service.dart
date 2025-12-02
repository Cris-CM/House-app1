import 'package:dio/dio.dart';
import 'package:house_app/domain/models/device_model.dart';
import 'package:house_app/domain/models/ia_response_model.dart';
import 'package:house_app/domain/models/response_model.dart';
import 'package:house_app/domain/models/room_model.dart';

class CommandService {
  final Dio dio;

  CommandService(this.dio);

  Future<IAResponseModel> sendCommand(String command) async {
    try {
      final response = await dio.post("ia/message", data: {"message": command});
      return IAResponseModel.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> setupPins() async {
    try {
      final response = await dio.post("house/setupPins", data: {"houseId": 1});
      return response.statusCode == 201;
    } catch (e) {
      rethrow;
    }
  }

  Future<ResponseModel<List<DeviceModel>>> getDevices() async {
    try {
      final response = await dio.post(
        "house/findDevicesByHouseId",
        data: {"houseId": 1},
      );

      return ResponseModel<List<DeviceModel>>(
        data: (response.data["data"] as List)
            .map((e) => DeviceModel.fromJson(e))
            .toList(),
        message: response.data["message"],
        code: response.data["code"],
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<ResponseModel<List<RoomModel>>> getRooms() async {
    try {
      final response = await dio.post(
        "house/findRoomsByHouseId",
        data: {"houseId": 1},
      );

      return ResponseModel<List<RoomModel>>(
        data: (response.data["data"] as List)
            .map((e) => RoomModel.fromJson(e))
            .toList(),
        message: response.data["message"],
        code: response.data["code"],
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<String> changeLight(int deviceId, bool isOn) async {
    try {
      final response = await dio.post(
        "house/lightDevice",
        data: {"deviceId": deviceId, "light": isOn},
      );
      if (response.statusCode == 201) {
        return response.data["message"];
      }
      return "error";
    } catch (e) {
      rethrow;
    }
  }
}
