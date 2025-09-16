import 'package:get_it/get_it.dart';
import 'package:house_app/app/network/dio.dart';
import 'package:house_app/app/services/command_service.dart';

final getIt = GetIt.instance;

void setupLocator() {
  getIt.registerLazySingleton<CommandService>(() => CommandService(dio));
}