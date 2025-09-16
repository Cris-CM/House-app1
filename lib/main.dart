import 'package:flutter/material.dart';
import 'ui/views/home_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Casa Inteligente',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: HomeView(),
    );
  }
}
