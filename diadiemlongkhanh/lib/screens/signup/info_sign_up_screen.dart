import 'package:diadiemlongkhanh/resources/app_constant.dart';
import 'package:diadiemlongkhanh/resources/asset_constant.dart';
import 'package:diadiemlongkhanh/routes/router_manager.dart';
import 'package:diadiemlongkhanh/services/api_service/api_client.dart';
import 'package:diadiemlongkhanh/services/di/di.dart';
import 'package:diadiemlongkhanh/services/storage/storage_service.dart';
import 'package:diadiemlongkhanh/utils/app_utils.dart';
import 'package:diadiemlongkhanh/widgets/main_button.dart';
import 'package:diadiemlongkhanh/widgets/main_text_form_field.dart';
import 'package:diadiemlongkhanh/widgets/my_appbar.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';

class InfoSignupScreen extends StatefulWidget {
  const InfoSignupScreen({
    Key? key,
    required this.otp,
    required this.phone,
  }) : super(key: key);
  final String otp;
  final String phone;
  @override
  State<InfoSignupScreen> createState() => _InfoSignupScreenState();
}

class _InfoSignupScreenState extends State<InfoSignupScreen> {
  bool _isShowPass = false;
  bool _isShowVerifyPass = false;
  final _nameCtler = TextEditingController();
  final _emailCtler = TextEditingController();
  final _passCtler = TextEditingController();
  final _verifyPassCtler = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  _signup() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    AppUtils.showLoading();
    final data = {
      "phone": widget.phone,
      "name": _nameCtler.text,
      "email": _emailCtler.text,
      "password": _passCtler.text,
      "otp": widget.otp,
    };
    final res = await injector.get<ApiClient>().registerConfirm(data);
    AppUtils.hideLoading();
    if (res != null) {
      if (res.error != null) {
        AppUtils.showOkDialog(context, res.error!);
        return;
      }
      AppUtils.showSuccessAlert(
        context,
        title: 'Đăng ký thành công!',
        okTitle: 'Xác nhận',
        okAction: () => _login(res.token!),
      );
      return;
    }
    AppUtils.showOkDialog(
      context,
      ConstantTitle.please_try_again,
    );
  }

  _saveTokenFCM() async {
    final token = await FirebaseMessaging.instance.getToken() ?? '';
    final data = {'token': token};
    await injector.get<ApiClient>().saveToken(data);
  }

  _login(String token) async {
    await injector.get<StorageService>().saveToken(token);
    await _saveTokenFCM();
    Navigator.of(context)
        .pushNamedAndRemoveUntil(RouterName.base_tabbar, (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: MyAppBar(
          isShowBgBackButton: true,
          title: 'Nhập thông tin',
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  const SizedBox(
                    height: 60,
                  ),
                  MainTextFormField(
                    hintText: 'Tên của bạn*',
                    maxLines: 1,
                    controller: _nameCtler,
                    onChanged: (val) {
                      _nameCtler.text.toTitleCase();
                    },
                    textCapitalization: TextCapitalization.words,
                    validator: (val) {
                      if (val == null || val == '') {
                        return 'Vui lòng nhập tên của bạn';
                      }
                      if (val.length < 3) {
                        return 'Tên của bạn phải tối thiểu 3 ký tự';
                      }
                      return null;
                    },
                    prefixIcon: SvgPicture.asset(
                      ConstantIcons.ic_person,
                      height: 20,
                      width: 20,
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  MainTextFormField(
                    hintText: 'Email',
                    maxLines: 1,
                    controller: _emailCtler,
                    validator: (val) {
                      if (val != '' && !AppUtils.isValidEmail(val ?? '')) {
                        return 'Email của bạn không hợp lệ';
                      }
                      return null;
                    },
                    prefixIcon: SvgPicture.asset(
                      ConstantIcons.ic_email,
                      height: 20,
                      width: 20,
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  MainTextFormField(
                    hintText: 'Nhập mật khẩu*',
                    maxLines: 1,
                    controller: _passCtler,
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
                        !_isShowPass
                            ? ConstantIcons.ic_eye_off
                            : ConstantIcons.ic_eye,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  MainTextFormField(
                    hintText: 'Nhập lại mật khẩu*',
                    maxLines: 1,
                    controller: _verifyPassCtler,
                    obscureText: !_isShowVerifyPass,
                    validator: (val) {
                      if (val == null || val == '') {
                        return 'Vui lòng nhập lại mật khẩu bên trên';
                      }
                      if (val != _passCtler.text) {
                        return 'Mật khẩu xác nhận chưa trùng khớp';
                      }
                      return null;
                    },
                    prefixIcon: SvgPicture.asset(
                      ConstantIcons.ic_lock,
                    ),
                    suffixIcon: GestureDetector(
                      onTap: () {
                        setState(() {
                          _isShowVerifyPass = !_isShowVerifyPass;
                        });
                      },
                      child: SvgPicture.asset(
                        !_isShowVerifyPass
                            ? ConstantIcons.ic_eye_off
                            : ConstantIcons.ic_eye,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 32,
                  ),
                  MainButton(
                    onPressed: _signup,
                    title: 'Xác nhận',
                    color: Theme.of(context).primaryColor,
                    textColor: Colors.white,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

extension StringCasingExtension on String {
  String toCapitalized() =>
      length > 0 ? '${this[0].toUpperCase()}${substring(1).toLowerCase()}' : '';
  String toTitleCase() => replaceAll(RegExp(' +'), ' ')
      .split(' ')
      .map((str) => str.toCapitalized())
      .join(' ');
}
