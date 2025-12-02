class IAResponseModel {
  final String? command;
  final String? respuesta;

  IAResponseModel({this.command, this.respuesta});

  factory IAResponseModel.fromJson(Map<String, dynamic> json) =>
      IAResponseModel(command: json["command"], respuesta: json["respuesta"]);

  Map<String, dynamic> toJson() => {"command": command, "respuesta": respuesta};
}
