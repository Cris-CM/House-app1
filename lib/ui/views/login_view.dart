import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:house_app/app/controllers/login_controller.dart';
import 'package:house_app/colors/palette.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.grey,
      appBar: AppBar(
        backgroundColor: Palette.grey,
        elevation: 0,
        title: Text(
          'Casa Inteligente',
          style: const TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: Palette.black,
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              TextFormField(
                controller: controller.usernameController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  hintText: 'Usuario',
                  hintStyle: TextStyle(color: Palette.grey),
                ),
              ),
              TextFormField(
                controller: controller.passwordController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  hintText: 'Contraseña',
                  hintStyle: TextStyle(color: Palette.grey),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  controller.login();
                },
                child: const Text('Iniciar Sesión'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
