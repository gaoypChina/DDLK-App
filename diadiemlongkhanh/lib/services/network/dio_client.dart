import 'dart:async';

import 'package:dio/dio.dart';

import 'interceptor/auth_interceptor.dart';

class DioClient {
  static late Dio _dio;
  static FutureOr<Dio> setup({
    required String baseUrl,
  }) async {
    final options = BaseOptions(
      responseType: ResponseType.json,
      validateStatus: (status) {
        return true;
      },
      baseUrl: baseUrl,
      headers: {},
    );
    // ignore: join_return_with_assignment
    _dio = Dio(options);

    /// Unified add authentication request header
    _dio.interceptors.add(AuthInterceptor());
    // _dio.interceptors.add(
    //   RetryOnConnectionChangeInterceptor(
    //     requestRetrier: DioConnectivityRequestRetrier(
    //       dio: _dio,
    //       connectivity: Connectivity(),
    //     ),
    //   ),
    // );

    /// Adapt data (according to your own data structure
    /// , you can choose to add it)
    // _dio.interceptors.add(TokenInterceptor(_dio));

    return _dio;
  }
}
