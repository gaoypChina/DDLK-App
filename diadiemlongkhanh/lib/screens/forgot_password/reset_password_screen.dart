import 'package:diadiemlongkhanh/resources/app_constant.dart';
import 'package:diadiemlongkhanh/resources/asset_constant.dart';
import 'package:diadiemlongkhanh/resources/color_constant.dart';
import 'package:diadiemlongkhanh/routes/router_manager.dart';
import 'package:diadiemlongkhanh/services/api_service/api_client.dart';
import 'package:diadiemlongkhanh/services/di/di.dart';
import 'package:diadiemlongkhanh/utils/app_utils.dart';
import 'package:diadiemlongkhanh/widgets/main_button.dart';
import 'package:diadiemlongkhanh/widgets/main_text_form_field.dart';
import 'package:diadiemlongkhanh/widgets/my_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({
    Key? key,
    required this.otp,
    required this.phone,
  }) : super(key: key);
  final String otp;
  final String phone;

  @override
  _ResetPasswordScreenState createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  bool _isShowPass = false;
  bool _isShowVerifyPass = false;
  final _passCtler = TextEditingController();
  final _verifyPassCtler = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  _updatePassword() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    FocusScope.of(context).unfocus();
    AppUtils.showLoading();
    final data = {
      "phone": widget.phone,
      "password": _passCtler.text,
      "otp": widget.otp,
    };
    final res = await injector.get<ApiClient>().resetPassword(data);
    AppUtils.hideLoading();
    if (res != null) {
      if (res.error != null) {
        AppUtils.showOkDialog(context, res.error!);
        return;
      }
      AppUtils.showSuccessAlert(
        context,
        title: 'Đặt lại mật khẩu thành công!',
        okTitle: 'Đăng nhập lại',
        okAction: () {
          Navigator.of(context).pop();
          Navigator.of(context).pop();
          Navigator.of(context).pop();
          Navigator.of(context).pop();
        },
      );
      return;
    }
    AppUtils.showOkDialog(
      context,
      ConstantTitle.please_try_again,
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: MyAppBar(
          title: 'Đặt lại mật khẩu',
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                SizedBox(
                  height: 60,
                ),
                MainTextFormField(
                  hintText: 'Tạo mật khẩu mới',
                  maxLines: 1,
                  obscureText: !_isShowPass,
                  controller: _passCtler,
                  prefixIcon: SvgPicture.asset(
                    ConstantIcons.ic_lock,
                  ),
                  validator: (val) {
                    if (val == null || val == '') {
                      return 'Vui lòng nhập mật khẩu của bạn';
                    }
                    if (val.length < 6) {
                      return 'Mật khẩu của bạn phải có ít nhất 6 ký tự';
                    }
                    return null;
                  },
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
                SizedBox(
                  height: 16,
                ),
                MainTextFormField(
                  hintText: 'Nhập lại mật khẩu',
                  maxLines: 1,
                  obscureText: !_isShowVerifyPass,
                  controller: _verifyPassCtler,
                  prefixIcon: SvgPicture.asset(
                    ConstantIcons.ic_lock,
                  ),
                  validator: (val) {
                    if (val == null || val == '') {
                      return 'Vui lòng nhập lại mật khẩu bên trên';
                    }
                    if (val != _passCtler.text) {
                      return 'Mật khẩu xác nhận chưa trùng khớp';
                    }
                    return null;
                  },
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
                SizedBox(
                  height: 32,
                ),
                MainButton(
                  onPressed: _updatePassword,
                  title: 'Xác nhận',
                  color: Theme.of(context).primaryColor,
                  textColor: Colors.white,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Alert with single button.
  _onAlertButtonPressed() {}
}
