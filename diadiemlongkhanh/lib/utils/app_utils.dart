import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:diadiemlongkhanh/config/env_config.dart';
import 'package:diadiemlongkhanh/models/remote/place_response/place_response.dart';
import 'package:diadiemlongkhanh/resources/asset_constant.dart';
import 'package:diadiemlongkhanh/resources/color_constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:url_launcher/url_launcher.dart';

class AppUtils {
  static void showLoading() {
    EasyLoading.show(
      maskType: EasyLoadingMaskType.black,
    );
  }

  static void hideLoading() {
    EasyLoading.dismiss();
  }

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
    if (width != null) {
      _path += '?w=$width';
    }
    if (height != null) {
      if (_path.contains('?')) {
        _path += '&h=$width';
      } else {
        _path += '?h=$width';
      }
    }

    return Environment().config.domain + _path;
  }

  static String getPlaceUrl(String slug) {
    return Environment().config.domain2 + 'dia-diem/$slug';
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

  static Color getOpeningColor(String status) {
    switch (status) {
      case 'is_open':
        return ColorConstant.green_primary;
      case 'is_closed':
        return ColorConstant.sematic_red;
      default:
        return ColorConstant.neutral_gray;
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
          return '${hours.truncate()} giờ trước';
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

  static showOkDialog(
    BuildContext context,
    String msg, {
    bool isCancel = false,
    Function()? okAction,
  }) async {
    if (Platform.isAndroid) {
      await _showAndroidOkDialog(
        context,
        msg,
        okAction: okAction,
        isCancel: isCancel,
      );
    } else {
      await _showIosOKDialog(
        context,
        msg,
        okAction: okAction,
        isCancel: isCancel,
      );
    }
  }

  static _showIosOKDialog(
    BuildContext context,
    String msg, {
    bool isCancel = false,
    Function()? okAction,
  }) async {
    var actions = [
      CupertinoDialogAction(
        child: Text('Đồng ý'),
        onPressed: () {
          Navigator.of(context).pop();
          if (okAction != null) {
            okAction();
          }
        },
      )
    ];
    if (isCancel) {
      actions.add(
        CupertinoDialogAction(
          child: Text('Huỷ bỏ'),
          isDestructiveAction: true,
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      );
    }
    await showCupertinoDialog(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: Text('Thông báo'),
        content: Text(msg),
        actions: actions,
      ),
    );
  }

  static _showAndroidOkDialog(
    BuildContext context,
    String msg, {
    bool isCancel = false,
    Function()? okAction,
  }) async {
    var actions = [
      TextButton(
        child: Text("Đồng ý"),
        onPressed: () {
          Navigator.of(context).pop();
          if (okAction != null) {
            okAction();
          }
        },
      )
    ];
    if (isCancel)
      actions.add(
        TextButton(
          child: Text('Huỷ bỏ'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Thông báo"),
      content: Text(msg),
      actions: actions,
    );

    // show the dialog
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  static Future<void> launchLink(String url) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
      return;
    }
  }

  static showSuccessAlert(
    BuildContext context, {
    String? title,
    String? okTitle,
    Function()? okAction,
  }) {
    Alert(
      context: context,
      image: SvgPicture.asset(ConstantIcons.ic_circle_check),
      closeIcon: SizedBox.shrink(),
      closeFunction: () {},
      title: title,
      style: AlertStyle(
        titleStyle: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w500,
          color: ColorConstant.neutral_black,
        ),
        buttonAreaPadding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 24,
        ),
      ),
      buttons: [
        DialogButton(
          child: Text(
            okTitle ?? '',
            style: TextStyle(
              color: Theme.of(context).primaryColor,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          height: 48,
          border: Border.all(color: Theme.of(context).primaryColor),
          color: Colors.white,
          onPressed: okAction,
        )
      ],
    ).show();
  }

  static bool isValidEmail(String email) {
    return RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(email);
  }

  static Widget buildProgressIndicator(BuildContext context) {
    return new Padding(
      padding: const EdgeInsets.all(8.0),
      child: new Center(
        child: new CircularProgressIndicator(
          color: Theme.of(context).primaryColor,
          strokeWidth: 2,
        ),
      ),
    );
  }

  static Future<String?> getUDID() async {
    var deviceInfo = DeviceInfoPlugin();
    if (Platform.isIOS) {
      var iosDeviceInfo = await deviceInfo.iosInfo;
      return iosDeviceInfo.identifierForVendor; // unique ID on iOS
    } else {
      var androidDeviceInfo = await deviceInfo.androidInfo;
      return androidDeviceInfo.androidId; // unique ID on Android
    }
  }

  static String getExpireDate(
    String endDate,
  ) {
    final end = DateTime.parse(endDate);
    final now = DateTime.now();
    if (now.isAfter(end)) {
      return 'Đã hết hạn';
    }
    final days = end.difference(now).inDays;
    if (days == 0) {
      return 'Còn hôm nay';
    }
    return 'Còn $days ngày';
  }
}
