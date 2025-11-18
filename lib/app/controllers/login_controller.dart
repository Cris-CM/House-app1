import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:house_app/app/network/dio.dart';
import 'package:house_app/app/services/auth_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginController extends GetxController {
  final AuthService authService = AuthService(dio);
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void login() async {
    final response = await authService.login(
      usernameController.text,
      passwordController.text,
    );
    if (response.code == 200) {
      final shared = await SharedPreferences.getInstance();
      shared.setString('userId', response.data?.id.toString() ?? '');
      Get.toNamed('/home');
    }
  }
}

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LoginController());
  }
}
