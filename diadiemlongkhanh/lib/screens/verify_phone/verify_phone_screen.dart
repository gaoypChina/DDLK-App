import 'dart:async';

import 'package:diadiemlongkhanh/resources/app_constant.dart';
import 'package:diadiemlongkhanh/resources/color_constant.dart';
import 'package:diadiemlongkhanh/routes/router_manager.dart';
import 'package:diadiemlongkhanh/services/api_service/api_client.dart';
import 'package:diadiemlongkhanh/services/di/di.dart';
import 'package:diadiemlongkhanh/services/storage/storage_service.dart';
import 'package:diadiemlongkhanh/utils/app_utils.dart';
import 'package:diadiemlongkhanh/widgets/my_back_button.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class VerifyPhoneScreen extends StatefulWidget {
  const VerifyPhoneScreen({
    Key? key,
    required this.phone,
    this.verifyType = VerifyPhoneType.signup,
  }) : super(key: key);
  final String phone;
  final VerifyPhoneType verifyType;

  @override
  _VerifyPhoneScreenState createState() => _VerifyPhoneScreenState();
}

class _VerifyPhoneScreenState extends State<VerifyPhoneScreen> {
  int _start = 120;
  late Timer _timer;
  @override
  void initState() {
    super.initState();
    startTimer();
  }

  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_start == 0) {
          setState(() {
            timer.cancel();
          });
        } else {
          setState(() {
            _start--;
          });
        }
      },
    );
  }

  _resendOtp() async {
    bool isDebug = false;
    if (kDebugMode) {
      isDebug = true;
    }
    final data = {
      "phone": widget.phone,
      "test": isDebug,
    };
    AppUtils.showLoading();
    final res = await injector.get<ApiClient>().resendOtp(data);
    AppUtils.hideLoading();
    if (res != null) {
      if (res.success == true) {
        AppUtils.showOkDialog(context, ConstantTitle.send_otp_success);
        _start = 120;
        startTimer();
        return;
      }
    }
    AppUtils.showOkDialog(context, ConstantTitle.please_try_again);
  }

  _login(String val) async {
    AppUtils.showLoading();
    final data = {
      "phone": widget.phone,
      "otp": val,
    };
    final res = await injector.get<ApiClient>().loginWithOtpConfirm(data);
    AppUtils.hideLoading();
    if (res != null) {
      if (res.error != null) {
        AppUtils.showOkDialog(context, res.error!);
        return;
      }
      if (res.token != null) {
        await injector.get<StorageService>().saveToken(res.token!);
        await _saveTokenFCM();
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

  _saveTokenFCM() async {
    final token = await FirebaseMessaging.instance.getToken() ?? '';
    final data = {'token': token};
    await injector.get<ApiClient>().saveToken(data);
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: MyBackButton(
          isShowBgBackButton: true,
        ),
        elevation: 0,
        title: Text(
          'Xác thực OTP',
          style: Theme.of(context).textTheme.headline1,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 50,
            ),
            Text(
              'Nhập mã gồm 6 chữ số',
              style: Theme.of(context).textTheme.headline5,
            ),
            Text(
              'Mã của bạn đã được gửi đến ${widget.phone}',
              style: TextStyle(
                fontSize: 12,
                color: ColorConstant.neutral_gray,
              ),
            ),
            SizedBox(
              height: 32,
            ),
            PinCodeTextField(
              appContext: context,
              pastedTextStyle: TextStyle(
                color: Colors.green.shade600,
                fontWeight: FontWeight.bold,
              ),
              length: 6,

              blinkWhenObscuring: true,
              animationType: AnimationType.fade,
              validator: (v) {
                if (v!.length < 6) {
                  return "Phải nhập đủ 6 chữ số";
                } else {
                  return null;
                }
              },
              pinTheme: PinTheme(
                shape: PinCodeFieldShape.box,
                borderWidth: 0,
                inactiveColor: ColorConstant.grey_EBEFF4,
                inactiveFillColor: ColorConstant.grey_EBEFF4,
                selectedFillColor: ColorConstant.grey_EBEFF4,
                borderRadius: BorderRadius.circular(4),
                fieldHeight: 48,
                fieldWidth: 48,
                activeFillColor: ColorConstant.grey_EBEFF4,
              ),
              cursorColor: Theme.of(context).primaryColor,
              animationDuration: Duration(milliseconds: 300),
              enableActiveFill: true,
              // errorAnimationController: errorController,
              // controller: textEditingController,
              keyboardType: TextInputType.number,

              onCompleted: (v) {
                print("Completed");
                if (widget.verifyType == VerifyPhoneType.signup) {
                  Navigator.of(context).pushNamed(
                    RouterName.info_signup,
                    arguments: {
                      'phone': widget.phone,
                      'otp': v,
                    },
                  );
                } else if (widget.verifyType == VerifyPhoneType.login) {
                  _login(v);
                } else {
                  Navigator.of(context).pushNamed(
                    RouterName.reset_password,
                    arguments: {
                      'phone': widget.phone,
                      'otp': v,
                    },
                  );
                }
              },
              // onTap: () {
              //   print("Pressed");
              // },
              onChanged: (value) {
                print(value);
              },
              beforeTextPaste: (text) {
                print("Allowing to paste $text");
                //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                //but you can show anything you want here, like your pop up saying wrong paste format or etc
                return true;
              },
            ),
            SizedBox(
              height: 16,
            ),
            Row(
              children: [
                Text(
                  'Bạn chưa nhận được mã xác thực ?',
                  style: Theme.of(context).textTheme.subtitle1,
                ),
                _start == 0
                    ? GestureDetector(
                        onTap: _resendOtp,
                        child: Text(
                          ' Gửi lại mã',
                          style: Theme.of(context).textTheme.headline2?.apply(
                                color: Theme.of(context).primaryColor,
                              ),
                        ),
                      )
                    : Text(
                        ' Gửi lại sau $_start giây',
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

enum VerifyPhoneType {
  signup,
  login,
  resetPass,
}
