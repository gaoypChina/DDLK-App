import 'package:diadiemlongkhanh/config/env_config.dart';
import 'package:flutter/material.dart';

class AppUtils {
  static showBottomDialog(
    BuildContext context,
    Widget screen,
  ) {
    Navigator.push(
      context,
      PageRouteBuilder(
        opaque: false,
        pageBuilder: (context, animation, secondaryAnimation) => screen,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(0.0, 1.0);
          const end = Offset.zero;
          const curve = Curves.ease;

          var tween =
              Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

          return SlideTransition(
            position: animation.drive(tween),
            child: child,
          );
        },
      ),
    );
  }

  static String getUrlImage(
    String path, {
    double? width,
    double? height,
  }) {
    String _path = path;
    if (path.contains('uploads')) {
      _path = path.replaceAll('uploads', 'static');
    }
    return Environment().config.domain + _path;
  }

  static String getOpeningTitle(String status) {
    switch (status) {
      case 'is_open':
        return 'Đang mở cửa';
      case 'is_closed':
        return 'Đang đóng cửa';
      default:
        return 'Sắp đóng cửa';
    }
  }

  static int getDistance(double meters) {
    if (meters > 99000 || meters == 0) {
      return 0;
    }
    final klm = (meters / 1000).round();
    return klm;
  }
}
