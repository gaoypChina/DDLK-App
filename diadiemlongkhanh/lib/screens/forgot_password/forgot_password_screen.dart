import 'package:diadiemlongkhanh/resources/app_constant.dart';
import 'package:diadiemlongkhanh/resources/asset_constant.dart';
import 'package:diadiemlongkhanh/routes/router_manager.dart';
import 'package:diadiemlongkhanh/screens/verify_phone/verify_phone_screen.dart';
import 'package:diadiemlongkhanh/services/api_service/api_client.dart';
import 'package:diadiemlongkhanh/services/di/di.dart';
import 'package:diadiemlongkhanh/utils/app_utils.dart';
import 'package:diadiemlongkhanh/widgets/main_button.dart';
import 'package:diadiemlongkhanh/widgets/main_text_form_field.dart';
import 'package:diadiemlongkhanh/widgets/my_appbar.dart';
import 'package:diadiemlongkhanh/widgets/phone_form_field.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _phoneCtler = TextEditingController();
  bool disable = false;
  @override
  void initState() {
    super.initState();
    _phoneCtler.addListener(() {
      setState(() {
        disable = _phoneCtler.text == '';
      });
    });
  }

  _forgotPassword() async {
    if (disable) {
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
    final res = await injector.get<ApiClient>().forgotPassword(data);
    AppUtils.hideLoading();
    if (res != null) {
      if (res.error != null) {
        AppUtils.showOkDialog(context, res.error!);
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
              'type': VerifyPhoneType.resetPass,
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

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: MyAppBar(
          title: 'Quên mật khẩu',
          isShowBgBackButton: true,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              SizedBox(
                height: 60,
              ),
              // MainTextFormField(
              //   hintText: 'Nhập email của bạn',
              //   prefixIcon: SvgPicture.asset(
              //     ConstantIcons.ic_mail,
              //   ),
              // ),
              PhoneFormField(
                controller: _phoneCtler,
              ),
              SizedBox(
                height: 32,
              ),
              MainButton(
                onPressed: _forgotPassword,
                title: 'Xác nhận',
                color: Theme.of(context).primaryColor,
                textColor: Colors.white,
              )
            ],
          ),
        ),
      ),
    );
  }
}
