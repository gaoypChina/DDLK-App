import 'package:diadiemlongkhanh/models/remote/category/category_response.dart';
import 'package:diadiemlongkhanh/models/remote/new_feed/new_feed_response.dart';
import 'package:diadiemlongkhanh/screens/base_tabbar/base_tabbar_screen.dart';

import 'package:diadiemlongkhanh/screens/forgot_password/forgot_password_screen.dart';
import 'package:diadiemlongkhanh/screens/forgot_password/reset_password_screen.dart';
import 'package:diadiemlongkhanh/screens/login/login_screen.dart';
import 'package:diadiemlongkhanh/screens/login/option_login_screen.dart';
import 'package:diadiemlongkhanh/screens/login/otp_login_screen.dart';
import 'package:diadiemlongkhanh/screens/new_feeds/detail_review_screen.dart';
import 'package:diadiemlongkhanh/screens/notifications/detail_notification_screen.dart';
import 'package:diadiemlongkhanh/screens/notifications/notification_screen.dart';
import 'package:diadiemlongkhanh/screens/places/bloc/detail_place_cubit.dart';
import 'package:diadiemlongkhanh/screens/places/bloc/list_places_cubit.dart';
import 'package:diadiemlongkhanh/screens/places/detail_place_screen.dart';
import 'package:diadiemlongkhanh/screens/places/list_place_screen.dart';
import 'package:diadiemlongkhanh/screens/profile/edit_profile_screen.dart';
import 'package:diadiemlongkhanh/screens/profile/setting_profile_screen.dart';
import 'package:diadiemlongkhanh/screens/profile/setting_screen.dart';
import 'package:diadiemlongkhanh/screens/promotion/bloc/detail_promotion_cubit.dart';
import 'package:diadiemlongkhanh/screens/promotion/detail_promotion_screen.dart';
import 'package:diadiemlongkhanh/screens/promotion/promotion_screen.dart';
import 'package:diadiemlongkhanh/screens/review/create_review_screen.dart';
import 'package:diadiemlongkhanh/screens/search/bloc/search_cubit.dart';
import 'package:diadiemlongkhanh/screens/search/search_screen.dart';
import 'package:diadiemlongkhanh/screens/signup/info_sign_up_screen.dart';
import 'package:diadiemlongkhanh/screens/signup/option_signup_screen.dart';
import 'package:diadiemlongkhanh/screens/signup/signup_screen.dart';
import 'package:diadiemlongkhanh/screens/verify_phone/verify_phone_screen.dart';
import 'package:diadiemlongkhanh/screens/welcome/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RouterManager {
  static Route<dynamic>? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouterName.option_login:
        bool isBack = false;
        if (settings.arguments != null) {
          isBack = settings.arguments as bool;
        }
        return MaterialPageRoute(
          builder: (_) => OptionLoginScreen(
            isBack: isBack,
          ),
        );
      case RouterName.option_signup:
        return MaterialPageRoute(
          builder: (_) => OptionSingupScreen(),
        );
      case RouterName.login:
        return MaterialPageRoute(
          builder: (_) => LoginScreen(),
        );
      case RouterName.verify_phone:
        String phone = '';
        if (settings.arguments != null) {
          phone = settings.arguments as String;
        }
        return MaterialPageRoute(
          builder: (_) => VerifyPhoneScreen(
            phone: phone,
          ),
        );
      case RouterName.forgot_password:
        return MaterialPageRoute(
          builder: (_) => ForgotPasswordScreen(),
        );
      case RouterName.reset_password:
        bool isReset = true;
        if (settings.arguments != null) {
          isReset = settings.arguments as bool;
        }
        return MaterialPageRoute(
          builder: (_) => ResetPasswordScreen(isReset),
        );
      case RouterName.signup:
        return MaterialPageRoute(
          builder: (_) => SignupScreen(),
        );
      case RouterName.welcome:
        return MaterialPageRoute(
          builder: (_) => WelcomeScreen(),
        );
      case RouterName.base_tabbar:
        return MaterialPageRoute(
          builder: (_) => BaseTabBarSreen(),
        );
      case RouterName.otp_login:
        return MaterialPageRoute(
          builder: (_) => OTPLoginScreen(),
        );
      case RouterName.create_review:
        return MaterialPageRoute(
          builder: (_) => CreateReviewScreen(),
        );
      case RouterName.promotion:
        return MaterialPageRoute(
          builder: (_) => PromotionScreen(),
        );
      case RouterName.detail_promotion:
        String? id;
        if (settings.arguments != null) {
          id = settings.arguments as String;
        }
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (_) => DetailPromotionCubit(id: id),
            child: DetailPromotionScreen(),
          ),
        );
      case RouterName.list_places:
        CategoryModel? subCategory;
        CategoryModel? category;
        bool nearMe = false;
        if (settings.arguments != null) {
          final arguments = settings.arguments as Map<String, dynamic>;
          if (arguments['sub_category'] != null) {
            subCategory = arguments['sub_category'] as CategoryModel;
          }
          if (arguments['category'] != null) {
            category = arguments['category'] as CategoryModel;
          }
          if (arguments['near_me'] != null) {
            nearMe = arguments['near_me'] as bool;
          }
        }
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (_) => ListPlacesCubit(
              subCategory: subCategory,
              category: category,
              nearMe: nearMe,
            ),
            child: ListPlaceScreen(),
          ),
        );
      case RouterName.setting:
        return MaterialPageRoute(
          builder: (_) => SettingScreen(),
        );
      case RouterName.setting_profile:
        return MaterialPageRoute(
          builder: (_) => SettingProfileScreen(),
        );
      case RouterName.edit_profile:
        return MaterialPageRoute(
          builder: (_) => EditProfileScreen(),
        );
      case RouterName.notification:
        return MaterialPageRoute(
          builder: (_) => NotificationScreen(),
        );
      case RouterName.detail_notification:
        return MaterialPageRoute(
          builder: (_) => DetailNotificationScreen(),
        );
      case RouterName.detail_place:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (_) => DetailPlaceCubit(settings.arguments as String),
            child: DetailPlaceScreen(),
          ),
        );
      case RouterName.search:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (_) => SearchCubit(),
            child: SearchScreen(),
          ),
        );
      case RouterName.detail_review:
        NewFeedModel? item;
        if (settings.arguments != null) {
          item = settings.arguments as NewFeedModel;
        }
        return MaterialPageRoute(
          builder: (_) => DetailReviewScreen(
            item: item,
          ),
        );
      case RouterName.info_signup:
        String otp = '';
        String phone = '';
        return MaterialPageRoute(
          builder: (_) => InfoSignupScreen(
            otp: otp,
            phone: phone,
          ),
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
  static const verify_phone = '/verify_phone';
  static const forgot_password = '/forgot_password';
  static const reset_password = '/reset_password';
  static const signup = '/signup';
  static const welcome = '/welcome';
  static const base_tabbar = '/base_tabbar';
  static const otp_login = '/otp_login';
  static const create_review = '/create_review';
  static const promotion = '/promotion';
  static const detail_promotion = '/detail_promotion';
  static const list_places = '/list_places';
  static const setting = '/setting';
  static const setting_profile = '/setting_profile';
  static const edit_profile = '/edit_profile';
  static const notification = '/notification';
  static const detail_notification = '/detail_notification';
  static const detail_place = '/detail_place';
  static const search = '/search';
  static const detail_review = '/detail_review';
  static const info_signup = '/info_signup';
}
