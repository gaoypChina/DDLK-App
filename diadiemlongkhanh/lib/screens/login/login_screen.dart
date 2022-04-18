import 'package:diadiemlongkhanh/resources/asset_constant.dart';
import 'package:diadiemlongkhanh/resources/color_constant.dart';
import 'package:diadiemlongkhanh/routes/router_manager.dart';
import 'package:diadiemlongkhanh/widgets/main_button.dart';
import 'package:diadiemlongkhanh/widgets/main_text_form_field.dart';
import 'package:diadiemlongkhanh/widgets/my_appbar.dart';
import 'package:diadiemlongkhanh/widgets/phone_form_field.dart';
import 'package:diadiemlongkhanh/widgets/segment_login_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: MyAppBar(
          title: 'Đăng nhập',
          isShowBackButton: false,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              _buildLoginWithEmailView(),
            ],
          ),
        ),
      ),
    );
  }

  Container _buildLoginWithEmailView() {
    return Container(
      margin: const EdgeInsets.only(top: 56),
      child: Column(
        children: [
          MainTextFormField(
            hintText: 'Nhập số điện thoại hoặc địa chỉ email',
            prefixIcon: SvgPicture.asset(
              ConstantIcons.ic_mail,
            ),
          ),
          SizedBox(
            height: 16,
          ),
          MainTextFormField(
            hintText: 'Nhập mật khẩu ',
            prefixIcon: SvgPicture.asset(
              ConstantIcons.ic_lock,
            ),
            suffixIcon: SvgPicture.asset(
              ConstantIcons.ic_eye_off,
            ),
          ),
          SizedBox(
            height: 8,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              GestureDetector(
                onTap: () =>
                    Navigator.of(context).pushNamed(RouterName.otp_login),
                child: Text(
                  'Đăng nhập bằng OTP',
                  style: TextStyle(
                    fontSize: 12,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              )
            ],
          ),
          SizedBox(
            height: 32,
          ),
          MainButton(
            onPressed: () => Navigator.of(context).pushNamedAndRemoveUntil(
                RouterName.base_tabbar, (route) => false),
            title: 'Đăng nhập',
            color: Theme.of(context).primaryColor,
            textColor: Colors.white,
          ),
          SizedBox(
            height: 24,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Bạn chưa có tài khoản ?',
                style: Theme.of(context).textTheme.bodyText1,
              ),
              GestureDetector(
                onTap: () =>
                    Navigator.of(context).pushNamed(RouterName.option_signup),
                child: Text(
                  ' Đăng ký',
                  style: Theme.of(context).textTheme.headline2?.apply(
                        color: Theme.of(context).primaryColor,
                      ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 8,
          ),
          GestureDetector(
            onTap: () =>
                Navigator.of(context).pushNamed(RouterName.forgot_password),
            child: Text(
              'Quên mật khẩu?',
              style: Theme.of(context).textTheme.bodyText1,
            ),
          ),
        ],
      ),
    );
  }
}
