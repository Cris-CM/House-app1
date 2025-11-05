import 'package:dio/dio.dart';
import 'package:house_app/domain/models/response_model.dart';
import 'package:house_app/domain/models/user_model.dart';

class AuthService {
  final Dio dio;

  AuthService(this.dio);

  Future<ResponseModel<UserModel>> login(
    String username,
    String password,
  ) async {
    try {
      final response = await dio.post(
        "auth/login",
        data: {"username": username, "password": password},
      );
      return ResponseModel<UserModel>(
        data: UserModel.fromJson(response.data["data"]),
        message: response.data["message"],
        code: response.data["code"],
      );
    } catch (e) {
      rethrow;
    }
  }
}
