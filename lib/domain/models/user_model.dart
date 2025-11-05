class UserModel {
  final int id;
  final String name;
  final String username;
  final String password;

  UserModel({
    required this.id,
    required this.name,
    required this.username,
    required this.password,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    id: json["id"],
    name: json["name"],
    username: json["username"],
    password: json["password"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "username": username,
    "password": password,
  };
}
