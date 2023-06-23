import 'package:diadiemlongkhanh/main.dart';
import 'package:diadiemlongkhanh/services/di/di.dart';
import 'package:diadiemlongkhanh/services/storage/storage_service.dart';
import 'package:diadiemlongkhanh/utils/app_utils.dart';
import 'package:dio/dio.dart';

class AuthInterceptor extends Interceptor {
  var _isExpired = false;
  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    final token = await injector.get<StorageService>().getToken();
    if (token != null) {
      options.headers['Authorization'] = 'Token $token';
    }

    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) async {
    if (response.statusCode == 401) {
      if (!_isExpired) {
        _isExpired = true;
        print('show');
        AppUtils.showOkDialog(navigatorKey.currentContext!,
            'Phiên đăng nhập hết hạn, vui lòng đăng nhập lại!', okAction: () {
          AppUtils.logout();
          _isExpired = false;
        });
      }
      response.requestOptions.extra["tokenErrorType"] = 'token expired';
      final error = DioError(
          requestOptions: response.requestOptions, type: DioErrorType.other);

      return handler.reject(error);
    }
    super.onResponse(response, handler);
  }
}
