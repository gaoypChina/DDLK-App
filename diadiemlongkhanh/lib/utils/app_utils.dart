import 'package:diadiemlongkhanh/config/env_config.dart';
import 'package:diadiemlongkhanh/models/remote/place_response/place_response.dart';
import 'package:diadiemlongkhanh/resources/color_constant.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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

  static double roundedRating(double rating) {
    var point = rating;
    var full = point.truncate();

    var half = (point - full);
    if (half >= 0.25) {
      half = 0.5;
    } else {
      half = 0;
    }

    return full + half;
  }

  static String convertDatetimePrefix(String time) {
    var postTime = DateTime.parse(time);
    var currentTime = DateTime.now();

    final distance = currentTime.difference(postTime).inSeconds;
    if (distance < AppConstant.DAY) {
      if (distance < AppConstant.MINUTE) {
        return 'Ngay bây giờ';
      } else {
        if (distance < AppConstant.HOUR) {
          double minutes = distance / AppConstant.MINUTE;
          return '${minutes.truncate()} phút trước';
        } else {
          double hours = distance / AppConstant.HOUR;
          return '${hours.truncate()}giờ trước';
        }
      }
    } else {
      return DateFormat('dd-MM-yyyy HH:mm').format(postTime);
    }
  }

  static String formatCurrency(int value) {
    final oCcy = new NumberFormat("#,##0", "vi_VN");
    return oCcy.format(value);
  }

  static String getTimeOpening(OpeningTimeModel time) {
    var date = DateTime.now();
    final day = DateFormat('EEE').format(date);
    print(day);
    switch (day.toLowerCase()) {
      case 'mon':
        return time.mon ?? '';
      case 'tue':
        return time.tue ?? '';
      case 'wed':
        return time.wed ?? '';
      case 'thu':
        return time.thu ?? '';
      case 'fri':
        return time.fri ?? '';
      case 'sat':
        return time.sat ?? '';
      case 'sun':
        return time.sun ?? '';
    }
    return '';
  }

  static String convertDateToString(
    DateTime date, {
    String format = 'dd/MM/yyyy',
  }) {
    return DateFormat(format).format(date);
  }
}
