import 'package:diadiemlongkhanh/routes/router_manager.dart';
import 'package:diadiemlongkhanh/widgets/main_button.dart';
import 'package:diadiemlongkhanh/widgets/my_appbar.dart';
import 'package:diadiemlongkhanh/widgets/phone_form_field.dart';
import 'package:flutter/material.dart';

class OTPLoginScreen extends StatefulWidget {
  const OTPLoginScreen({Key? key}) : super(key: key);

  @override
  _OTPLoginScreenState createState() => _OTPLoginScreenState();
}

class _OTPLoginScreenState extends State<OTPLoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
    );
  }

  Container _buildLoginWithPhoneView() {
    return Container(
      child: Column(
        children: [
          PhoneFormField(),
          SizedBox(
            height: 32,
          ),
          MainButton(
            onPressed: () =>
                Navigator.of(context).pushNamed(RouterName.verify_phone),
            color: Theme.of(context).primaryColor, //ColorConstant.grey_F5F5F5,
            title: 'Yêu cầu OTP',
            textColor: Colors.white, //ColorConstant.border_gray2,
          )
        ],
      ),
    );
  }
}
