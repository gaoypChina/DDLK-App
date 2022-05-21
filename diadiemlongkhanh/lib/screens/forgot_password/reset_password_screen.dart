import 'package:diadiemlongkhanh/resources/asset_constant.dart';
import 'package:diadiemlongkhanh/resources/color_constant.dart';
import 'package:diadiemlongkhanh/widgets/main_button.dart';
import 'package:diadiemlongkhanh/widgets/main_text_form_field.dart';
import 'package:diadiemlongkhanh/widgets/my_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class ResetPasswordScreen extends StatefulWidget {
  final bool isReset;
  ResetPasswordScreen(this.isReset);

  @override
  _ResetPasswordScreenState createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: MyAppBar(
        title: widget.isReset ? 'Đặt lại mật khẩu' : 'Đặt mật khẩu',
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            SizedBox(
              height: 60,
            ),
            MainTextFormField(
              hintText: 'Tạo mật khẩu mới',
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
              hintText: 'Nhập lại mật khẩu',
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
              onPressed: _onAlertButtonPressed,
              title: 'Xác nhận',
              color: Theme.of(context).primaryColor,
              textColor: Colors.white,
            )
          ],
        ),
      ),
    );
  }

  // Alert with single button.
  _onAlertButtonPressed() {}
}
