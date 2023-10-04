import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:viacepapp/respositories/back4app/back4app_dio_interceptor.dart';

class Back4AppCustomDio {
  final _back4AppCustomDio = Dio();

  get dio => _back4AppCustomDio;

  Back4AppCustomDio() {
    _back4AppCustomDio.options.headers["Content-Type"] = "application/json";
    _back4AppCustomDio.options.baseUrl = dotenv.get("BACK4APP_BASE_URL");
    _back4AppCustomDio.interceptors.add(Black4AppDioInterceptor());
  }
}
