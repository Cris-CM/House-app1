import 'package:get/route_manager.dart';
import 'package:house_app/app/controllers/home_controller.dart';
import 'package:house_app/app/controllers/login_controller.dart';
import 'package:house_app/ui/views/home_view.dart';
import 'package:house_app/ui/views/login_view.dart';

final router = <GetPage>[
  GetPage(
    name: '/login',
    page: () => const LoginView(),
    binding: LoginBinding(),
  ),
  GetPage(name: '/home', page: () => const HomeView(), binding: HomeBinding()),
];
