import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:house_app/app/blocs/home_bloc/home_bloc.dart';
import 'package:house_app/app/injector/injector.dart';
import 'package:house_app/app/services/command_service.dart';
import 'ui/views/home_view.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  setupLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => HomeBloc(getIt<CommandService>())),
      ],
      child: MaterialApp(
        title: 'Casa Inteligente',
        theme: ThemeData(primarySwatch: Colors.blue),
        home: HomeView(),
      ),
    );
  }
}
