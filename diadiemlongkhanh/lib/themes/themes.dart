import 'package:diadiemlongkhanh/resources/color_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

enum AppThemeKeys { light, dark }

final Map<AppThemeKeys, ThemeData> _themes = {
  AppThemeKeys.light: ThemeData(
    primaryColor: ColorConstant.green_primary,
    fontFamily: 'Roboto',
    sliderTheme: SliderThemeData(overlayShape: SliderComponentShape.noOverlay),
    textTheme: TextTheme(
        headline1: TextStyle(
          fontFamily: 'Roboto',
          fontWeight: FontWeight.w500,
          fontSize: 24,
          color: ColorConstant.neutral_black,
        ),
        headline2: TextStyle(
          fontFamily: 'Roboto',
          fontWeight: FontWeight.w500,
          fontSize: 14,
          color: ColorConstant.neutral_black,
        ),
        headline3: TextStyle(
          fontFamily: 'Roboto',
          fontWeight: FontWeight.w500,
          fontSize: 18,
          color: ColorConstant.neutral_black,
        ),
        headline4: TextStyle(
          fontFamily: 'Roboto',
          fontWeight: FontWeight.w500,
          fontSize: 16,
          color: ColorConstant.neutral_black,
        ),
        headline5: TextStyle(
          fontFamily: 'Roboto',
          fontWeight: FontWeight.w700,
          fontSize: 18,
          color: ColorConstant.neutral_black,
        ),
        headline6: TextStyle(
          fontFamily: 'Roboto',
          fontWeight: FontWeight.w700,
          fontSize: 16,
          color: ColorConstant.neutral_black,
        ),
        subtitle1: TextStyle(
          fontFamily: 'Roboto',
          fontSize: 14,
          color: ColorConstant.neutral_gray,
          fontWeight: FontWeight.w400,
        ),
        bodyText1: TextStyle(
          fontFamily: 'Roboto',
          fontSize: 14,
          color: ColorConstant.neutral_black,
          fontWeight: FontWeight.w400,
        ),
        bodyText2: TextStyle(
          fontFamily: 'Roboto',
          fontSize: 16,
          color: ColorConstant.neutral_black,
          fontWeight: FontWeight.w400,
        )),
  ),
  AppThemeKeys.dark: ThemeData(
    primaryColor: Colors.green,
  ),
};

class AppTheme extends ChangeNotifier {
  static AppTheme of(BuildContext context, {bool listen = false}) =>
      Provider.of<AppTheme>(context, listen: listen);

  // Đây sẽ là state chính của class, chứa tên của theme, mặc định mình set là light
  AppThemeKeys _themeKey = AppThemeKeys.light;

  ThemeData get currentTheme => _themes[_themeKey]!;
  AppThemeKeys get currentThemeKey => _themeKey;

  // Đổi theme sang một theme khác
  void setTheme(AppThemeKeys themeKey) {
    _themeKey = themeKey;
    notifyListeners();
  }

  void switchTheme() {
    if (_themeKey == AppThemeKeys.dark) {
      _themeKey = AppThemeKeys.light;
    } else {
      _themeKey = AppThemeKeys.dark;
    }
    notifyListeners();
  }
}
