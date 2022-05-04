import 'package:diadiemlongkhanh/config/env_config.dart';
import 'package:diadiemlongkhanh/services/api_service/api_client.dart';
import 'package:diadiemlongkhanh/services/network/dio_client.dart';
import 'package:diadiemlongkhanh/services/network/logger.dart';
import 'package:diadiemlongkhanh/services/storage/storage_service.dart';
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

GetIt injector = GetIt.instance;

class DependencyInjection {
  static Future<void> inject() async {
    final shared = await SharedPreferences.getInstance();
    injector.registerSingleton<StorageService>(StorageService(shared));

    final _dio = await DioClient.setup(
      baseUrl: Environment().config.apiHost,
    );
    if (kDebugMode) {
      _dio.interceptors.add(LoggerInterceptor());
    }
    injector.registerSingleton<ApiClient>(
      ApiClient(
        _dio,
      ),
    );
  }
}
