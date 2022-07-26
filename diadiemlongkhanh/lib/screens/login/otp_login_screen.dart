import 'package:diadiemlongkhanh/resources/app_constant.dart';
import 'package:diadiemlongkhanh/routes/router_manager.dart';
import 'package:diadiemlongkhanh/screens/verify_phone/verify_phone_screen.dart';
import 'package:diadiemlongkhanh/services/api_service/api_client.dart';
import 'package:diadiemlongkhanh/services/di/di.dart';
import 'package:diadiemlongkhanh/utils/app_utils.dart';
import 'package:diadiemlongkhanh/widgets/main_button.dart';
import 'package:diadiemlongkhanh/widgets/my_appbar.dart';
import 'package:diadiemlongkhanh/widgets/phone_form_field.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class OTPLoginScreen extends StatefulWidget {
  const OTPLoginScreen({Key? key}) : super(key: key);

  @override
  _OTPLoginScreenState createState() => _OTPLoginScreenState();
}

class _OTPLoginScreenState extends State<OTPLoginScreen> {
  final _phoneCtler = TextEditingController();
  bool isDisable = true;
  @override
  void initState() {
    super.initState();
    _phoneCtler.addListener(() {
      setState(() {
        isDisable = _phoneCtler.text == '';
      });
    });
  }

  _requestOtp() async {
    if (isDisable) {
      return;
    }
    bool isDebug = false;
    if (kDebugMode) {
      isDebug = true;
    }
    AppUtils.showLoading();
    final data = {
      'phone': _phoneCtler.text,
      'test': isDebug,
    };

    final res = await injector.get<ApiClient>().loginWithOtp(data);
    AppUtils.hideLoading();
    if (res != null) {
      if (res.error != null) {
        AppUtils.showOkDialog(
          context,
          'Số điện thoại này chưa được đăng ký, bạn có muốn đăng ký không?',
          okAction: () => _register(data),
          isCancel: true,
        );
        return;
      }
      if (res.success == true) {
        AppUtils.showOkDialog(
          context,
          'Hệ thống sẽ gửi mã OTP thông qua cuộc gọi, vui lòng chú ý tới điện thoại của bạn',
          okAction: () => Navigator.of(context).pushNamed(
            RouterName.verify_phone,
            arguments: {
              'phone': _phoneCtler.text,
              'type': VerifyPhoneType.login,
            },
          ),
        );

        return;
      }
    }
    AppUtils.showOkDialog(
      context,
      ConstantTitle.please_try_again,
    );
  }

  _register(dynamic data) async {
    AppUtils.showLoading();
    final res = await injector.get<ApiClient>().registerWithPhone(data);
    AppUtils.hideLoading();
    if (res != null) {
      if (res.error != null) {
        AppUtils.showOkDialog(context, res.error!);
        return;
      }
      AppUtils.showOkDialog(
        context,
        'Hệ thống sẽ gửi mã OTP thông qua cuộc gọi, vui lòng chú ý tới điện thoại của bạn',
        okAction: () => Navigator.of(context).pushNamed(
          RouterName.verify_phone,
          arguments: {
            'phone': _phoneCtler.text,
          },
        ),
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
          title: 'Đăng nhập',
          isShowBgBackButton: true,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              _buildLoginWithPhoneView(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLoginWithPhoneView() {
    return Column(
      children: [
        PhoneFormField(
          controller: _phoneCtler,
        ),
        const SizedBox(
          height: 32,
        ),
        MainButton(
          onPressed: _requestOtp,
          color: isDisable
              ? Theme.of(context).primaryColor.withOpacity(0.7)
              : Theme.of(context).primaryColor, //ColorConstant.grey_F5F5F5,
          title: 'Yêu cầu OTP',
          textColor: Colors.white, //ColorConstant.border_gray2,
        )
      ],
    );
  }
}
