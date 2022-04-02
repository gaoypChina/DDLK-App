import 'package:diadiemlongkhanh/screens/login/login_screen.dart';
import 'package:diadiemlongkhanh/screens/login/option_login_screen.dart';
import 'package:diadiemlongkhanh/screens/signup/option_signup_screen.dart';
import 'package:flutter/material.dart';

class RouterManager {
  static Route<dynamic>? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouterName.option_login:
        return MaterialPageRoute(
          builder: (_) => OptionLoginScreen(),
        );
      case RouterName.option_signup:
        return MaterialPageRoute(
          builder: (_) => OptionSingupScreen(),
        );
      case RouterName.login:
        return MaterialPageRoute(
          builder: (_) => LoginScreen(),
        );

      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('No route defined for ${settings.name}')),
          ),
        );
    }
  }
}

class RouterName {
  static const option_login = '/option_login';
  static const option_signup = '/option_signup';
  static const login = '/login';
}
