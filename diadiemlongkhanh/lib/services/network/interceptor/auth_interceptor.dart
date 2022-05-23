import 'package:diadiemlongkhanh/services/di/di.dart';
import 'package:diadiemlongkhanh/services/storage/storage_service.dart';
import 'package:dio/dio.dart';

class AuthInterceptor extends Interceptor {
  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    final token = await injector.get<StorageService>().getToken();
    if (token != null) {
      options.headers['Authorization'] = 'Token $token';
    }

    super.onRequest(options, handler);
  }
}
