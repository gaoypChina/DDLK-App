import 'package:diadiemlongkhanh/resources/app_constant.dart';
import 'package:diadiemlongkhanh/resources/asset_constant.dart';
import 'package:diadiemlongkhanh/routes/router_manager.dart';
import 'package:diadiemlongkhanh/services/api_service/api_client.dart';
import 'package:diadiemlongkhanh/services/di/di.dart';
import 'package:diadiemlongkhanh/services/storage/storage_service.dart';
import 'package:diadiemlongkhanh/utils/app_utils.dart';
import 'package:diadiemlongkhanh/utils/global_value.dart';
import 'package:diadiemlongkhanh/widgets/main_button.dart';
import 'package:diadiemlongkhanh/widgets/main_text_form_field.dart';
import 'package:diadiemlongkhanh/widgets/my_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _phoneCtler = TextEditingController();
  final _passCtler = TextEditingController();
  bool _isShowPass = false;
  final _formKey = GlobalKey<FormState>();

  _login() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    FocusScope.of(context).unfocus();
    AppUtils.showLoading();
    final data = {
      'phone': _phoneCtler.text,
      'password': _passCtler.text,
    };
    final res = await injector.get<ApiClient>().loginBasic(data);
    AppUtils.hideLoading();
    if (res != null) {
      if (res.error != null) {
        AppUtils.showOkDialog(context, res.error!);
        return;
      }
      if (res.token != null) {
        await injector.get<StorageService>().saveToken(res.token!);
        await _getInfoUser();
        Navigator.of(context)
            .pushNamedAndRemoveUntil(RouterName.base_tabbar, (route) => false);
        return;
      }
    }
    AppUtils.showOkDialog(
      context,
      ConstantTitle.please_try_again,
    );
  }

  _getInfoUser() async {
    final res = await injector.get<ApiClient>().getProfile();
    if (res != null && res.info != null) {
      GlobalValue.name = res.info!.name;
      GlobalValue.id = res.info!.id;
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: MyAppBar(
            title: 'Đăng nhập',
            isShowBgBackButton: true,
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  _buildLoginWithEmailView(),
                ],
              ),
            ),
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
            hintText: 'Nhập số điện thoại',
            controller: _phoneCtler,
            maxLines: 1,
            keyboardType: TextInputType.phone,
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
            ],
            maxLength: 11,
            validator: (val) {
              if (val == null || val == '') {
                return 'Vui lòng nhập số điện thoại của bạn';
              }
              return null;
            },
            prefixIcon: SvgPicture.asset(
              ConstantIcons.ic_user,
            ),
          ),
          SizedBox(
            height: 16,
          ),
          MainTextFormField(
            hintText: 'Nhập mật khẩu ',
            controller: _passCtler,
            maxLines: 1,
            obscureText: !_isShowPass,
            validator: (val) {
              if (val == null || val == '') {
                return 'Vui lòng nhập mật khẩu của bạn';
              }
              if (val.length < 6) {
                return 'Mật khẩu của bạn phải có ít nhất 6 ký tự';
              }
              return null;
            },
            prefixIcon: SvgPicture.asset(
              ConstantIcons.ic_lock,
            ),
            suffixIcon: GestureDetector(
              onTap: () {
                setState(() {
                  _isShowPass = !_isShowPass;
                });
              },
              child: SvgPicture.asset(
                !_isShowPass ? ConstantIcons.ic_eye_off : ConstantIcons.ic_eye,
              ),
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
            onPressed: _login,
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
                onTap: () => Navigator.of(context).pushNamed(RouterName.signup),
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
