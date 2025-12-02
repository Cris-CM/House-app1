import 'package:house_app/domain/models/device_model.dart';

class RoomModel {
  final int id;
  final String name;
  final int houseId;
  final int temperature;
  final bool light;
  final bool ventilation;
  final List<DeviceModel> devices;

  RoomModel({
    required this.id,
    required this.name,
    required this.houseId,
    required this.temperature,
    required this.light,
    required this.ventilation,
    required this.devices,
  });

  factory RoomModel.fromJson(Map<String, dynamic> json) => RoomModel(
    id: json["id"],
    name: json["name"],
    houseId: json["house_id"],
    temperature: json["temperature"],
    light: json["light"],
    ventilation: json["ventilation"],
    devices: List<DeviceModel>.from(
      json["devices"].map((x) => DeviceModel.fromJson(x)),
    ),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "house_id": houseId,
    "temperature": temperature,
    "light": light,
    "ventilation": ventilation,
    "devices": List<dynamic>.from(devices.map((x) => x.toJson())),
  };
}
