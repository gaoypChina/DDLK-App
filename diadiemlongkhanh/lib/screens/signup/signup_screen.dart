import 'package:diadiemlongkhanh/resources/asset_constant.dart';
import 'package:diadiemlongkhanh/routes/router_manager.dart';
import 'package:diadiemlongkhanh/widgets/main_button.dart';
import 'package:diadiemlongkhanh/widgets/main_text_form_field.dart';
import 'package:diadiemlongkhanh/widgets/my_appbar.dart';
import 'package:diadiemlongkhanh/widgets/phone_form_field.dart';
import 'package:diadiemlongkhanh/widgets/segment_login_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  int indexSelected = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: MyAppBar(
        title: 'Đăng ký',
        isShowBgBackButton: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            // SegmentLoginView(
            //   margin: const EdgeInsets.only(top: 50),
            //   onChanged: (val) {
            //     setState(() {
            //       indexSelected = val;
            //     });
            //   },
            // ),
            _buildSignupWithPhoneView()
          ],
        ),
      ),
    );
  }

  Container _buildSignupWithEmailView() {
    return Container(
      margin: const EdgeInsets.only(top: 56),
      child: Column(
        children: [
          MainTextFormField(
            hintText: 'Nhập email của bạn',
            prefixIcon: SvgPicture.asset(
              ConstantIcons.ic_mail,
            ),
          ),
          SizedBox(
            height: 16,
          ),
          MainTextFormField(
            hintText: 'Nhập mật khẩu',
            prefixIcon: SvgPicture.asset(
              ConstantIcons.ic_lock,
            ),
            suffixIcon: SvgPicture.asset(
              ConstantIcons.ic_eye_off,
            ),
          ),
          SizedBox(
            height: 16,
          ),
          MainTextFormField(
            hintText: 'Nhập mật khẩu',
            prefixIcon: SvgPicture.asset(
              ConstantIcons.ic_lock,
            ),
            suffixIcon: SvgPicture.asset(
              ConstantIcons.ic_eye_off,
            ),
          ),
          SizedBox(
            height: 32,
          ),
          MainButton(
            title: 'Đăng nhập',
            color: Theme.of(context).primaryColor,
            textColor: Colors.white,
          ),
        ],
      ),
    );
  }

  Container _buildSignupWithPhoneView() {
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
