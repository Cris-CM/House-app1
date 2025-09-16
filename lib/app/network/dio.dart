import 'package:dio/dio.dart';
import 'package:house_app/app/utils/constants.dart';

final dio = Dio(BaseOptions(baseUrl: Constants.baseUrl));