import 'dart:io';

import 'package:dio/adapter.dart';

import 'pretty_dio_logger.dart';
import 'package:dio/dio.dart';

class DioService {
  Dio get dio => _dio();

  Dio _dio() {
    final options = BaseOptions(
        connectTimeout: 60000,
        receiveTimeout: 60000,
        followRedirects: false,
        baseUrl: 'https://api-dev.my-acq.com/api/v1',
        validateStatus: (status) {
          return status! < 500;
        },
        headers: {
          "Accept": "application/json",
        });

    var dio = Dio(options);

    (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (HttpClient client) {
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      return client;
    };

    dio.interceptors.add(PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: true,
        request: true,
        error: true,
        compact: true,
        maxWidth: 1000));
    return dio;
  }
}
