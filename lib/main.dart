import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:house_app/app/router.dart';
import 'package:sizer/sizer.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return GetMaterialApp(
          getPages: router,
          initialRoute: '/splash',
          title: 'Casa Inteligente',
          theme: ThemeData(primarySwatch: Colors.blue),
        );
      },
    );
  }
}
