class DeviceModel {
  final int id;
  final String name;
  final int roomId;
  final int temperature;
  final bool light;
  final bool ventilation;
  final bool alarm;
  final int pinId;
  final bool doorOpen;

  DeviceModel({
    required this.id,
    required this.name,
    required this.roomId,
    required this.temperature,
    required this.light,
    required this.ventilation,
    required this.alarm,
    required this.pinId,
    required this.doorOpen,
  });

  factory DeviceModel.fromJson(Map<String, dynamic> json) => DeviceModel(
    id: json["id"],
    name: json["name"],
    roomId: json["room_id"],
    temperature: json["temperature"],
    light: json["light"],
    ventilation: json["ventilation"],
    alarm: json["alarm"],
    pinId: json["pinId"],
    doorOpen: json["doorOpen"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "room_id": roomId,
    "temperature": temperature,
    "light": light,
    "ventilation": ventilation,
    "alarm": alarm,
    "pinId": pinId,
    "doorOpen": doorOpen,
  };

  DeviceModel copyWith({
    int? id,
    String? name,
    int? roomId,
    int? temperature,
    bool? light,
    bool? ventilation,
    bool? alarm,
    int? pinId,
    bool? doorOpen,
  }) {
    return DeviceModel(
      id: id ?? this.id,
      name: name ?? this.name,
      roomId: roomId ?? this.roomId,
      temperature: temperature ?? this.temperature,
      light: light ?? this.light,
      ventilation: ventilation ?? this.ventilation,
      alarm: alarm ?? this.alarm,
      pinId: pinId ?? this.pinId,
      doorOpen: doorOpen ?? this.doorOpen,
    );
  }
}
