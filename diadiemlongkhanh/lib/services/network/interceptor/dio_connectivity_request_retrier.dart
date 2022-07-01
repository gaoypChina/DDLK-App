import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:diadiemlongkhanh/main.dart';
import 'package:diadiemlongkhanh/resources/app_constant.dart';
import 'package:diadiemlongkhanh/utils/app_utils.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

bool isConnect = true;

class DioConnectivityRequestRetrier {
  final Dio dio;
  final Connectivity connectivity;

  DioConnectivityRequestRetrier({
    required this.dio,
    required this.connectivity,
  });

  Future<Response> scheduleRequestRetry(RequestOptions requestOptions) async {
    StreamSubscription? streamSubscription;
    final responseCompleter = Completer<Response>();
    final res = await connectivity.checkConnectivity();
    print(res);
    if (res == ConnectivityResult.none) {
      if (!isConnect) {
        return responseCompleter.future;
      }
      isConnect = false;
      AppUtils.hideLoading();
      AppUtils.showOkDialog(
        navigatorKey.currentState!.context,
        ConstantTitle.disconnect_internet,
      );
      return responseCompleter.future;
    }
    isConnect = true;
    streamSubscription = connectivity.onConnectivityChanged.listen(
      (connectivityResult) {
        if (connectivityResult == ConnectivityResult.none) {
          if (isConnect) {
            isConnect = false;
            AppUtils.hideLoading();
            AppUtils.showOkDialog(
              navigatorKey.currentState!.context,
              ConstantTitle.disconnect_internet,
            );
          }
        } else {
          isConnect = true;
        }
        if (connectivityResult != ConnectivityResult.none) {
          streamSubscription?.cancel();
          responseCompleter.complete(
            dio.request(
              requestOptions.path,
              cancelToken: requestOptions.cancelToken,
              data: requestOptions.data,
              onReceiveProgress: requestOptions.onReceiveProgress,
              onSendProgress: requestOptions.onSendProgress,
              queryParameters: requestOptions.queryParameters,
              options: Options(
                method: requestOptions.method,
                headers: requestOptions.headers,
                extra: requestOptions.extra,
                responseType: requestOptions.responseType,
                contentType: requestOptions.contentType,
              ),
            ),
          );
        }
      },
    );

    return responseCompleter.future;
  }
}
