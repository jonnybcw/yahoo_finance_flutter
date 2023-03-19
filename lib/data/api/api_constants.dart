import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';

class ApiConstants {
  static String chart(String symbol) => '/finance/chart/$symbol';

  static const String baseURL = 'https://query2.finance.yahoo.com/v8';

  static Dio getDioClient([String? customUrl]) {
    var options = BaseOptions(
      baseUrl: customUrl ?? baseURL,
      connectTimeout: 60000,
      receiveTimeout: 60000,
    );
    Dio dio = Dio(options);
    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        log('REQUEST[${options.method}] => PATH: ${options.baseUrl}${options.path}\n OPTIONS ${options.headers}\n DATA ${options.data} ');
        handler.next(options);
      },
      onResponse: (response, handler) async {
        log('RESPONSE[${response.requestOptions.method}] => PATH: ${response.requestOptions.path} [${response.statusCode}]\nBODY:\n${jsonEncode(response.data)}\nHEADERS \n${response.headers}\n');
        handler.next(response);
      },
      onError: (error, handler) async {
        log('ERROR -> ${error.response}');
        handler.next(error);
      },
    ));
    return dio;
  }
}
