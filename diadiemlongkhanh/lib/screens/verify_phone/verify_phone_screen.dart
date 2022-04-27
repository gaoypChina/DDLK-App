import 'package:diadiemlongkhanh/resources/color_constant.dart';
import 'package:diadiemlongkhanh/routes/router_manager.dart';
import 'package:diadiemlongkhanh/widgets/my_back_button.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class VerifyPhoneScreen extends StatefulWidget {
  const VerifyPhoneScreen({Key? key}) : super(key: key);

  @override
  _VerifyPhoneScreenState createState() => _VerifyPhoneScreenState();
}

class _VerifyPhoneScreenState extends State<VerifyPhoneScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: MyBackButton(),
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
              'Mã của bạn đã được gửi đến +84 328391129',
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
                if (v!.length < 3) {
                  return "I'm from validator";
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
                Navigator.of(context).pushNamed(
                  RouterName.reset_password,
                  arguments: false,
                );
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
                GestureDetector(
                  onTap: () {},
                  child: Text(
                    ' Gửi lại mã',
                    style: Theme.of(context).textTheme.headline2?.apply(
                          color: Theme.of(context).primaryColor,
                        ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
