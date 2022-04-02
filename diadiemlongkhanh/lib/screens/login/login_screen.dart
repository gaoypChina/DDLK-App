import 'package:diadiemlongkhanh/resources/asset_constant.dart';
import 'package:diadiemlongkhanh/resources/color_constant.dart';
import 'package:diadiemlongkhanh/routes/router_manager.dart';
import 'package:diadiemlongkhanh/widgets/main_button.dart';
import 'package:diadiemlongkhanh/widgets/main_text_form_field.dart';
import 'package:diadiemlongkhanh/widgets/my_back_button.dart';
import 'package:diadiemlongkhanh/widgets/segment_login_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  int indexSelected = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'Đăng nhập',
          style: Theme.of(context).textTheme.headline1,
        ),
        leading: MyBackButton(),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            SizedBox(
              height: 50,
            ),
            SegmentLoginView(
              onChanged: (val) {
                setState(() {
                  indexSelected = val;
                });
              },
            ),
            indexSelected == 0
                ? _buildLoginWithPhoneView()
                : Container(
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
                          hintText: 'Nhập mật khẩu ',
                          prefixIcon: SvgPicture.asset(
                            ConstantIcons.ic_lock,
                          ),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              'Quên mật khẩu?',
                              style: TextStyle(
                                fontSize: 12,
                                color: Theme.of(context).primaryColor,
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 32,
                        ),
                        MainButton(
                          title: 'Đăng nhập',
                          color: Theme.of(context).primaryColor,
                          textColor: Colors.white,
                        )
                      ],
                    ),
                  ),
          ],
        ),
      ),
    );
  }

  Container _buildLoginWithPhoneView() {
    return Container(
      child: Column(
        children: [
          _buildPhoneFormField(),
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

  Container _buildPhoneFormField() {
    return Container(
      height: 48,
      margin: const EdgeInsets.only(top: 56),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        border: Border.all(
          color: ColorConstant.border_gray,
        ),
      ),
      child: Row(
        children: [
          Text(
            'VN +84',
            style: Theme.of(context).textTheme.bodyText1,
          ),
          Icon(
            Icons.arrow_drop_down,
            color: ColorConstant.neutral_black,
          ),
          SizedBox(
            width: 12,
          ),
          Container(
            width: 1,
            height: 22,
            color: ColorConstant.border_gray2,
          ),
          Expanded(
            child: TextFormField(
              style: Theme.of(context).textTheme.bodyText1,
              decoration: InputDecoration(
                hintStyle: Theme.of(context).textTheme.subtitle1,
                hintText: 'Số điện thoại',
                contentPadding: const EdgeInsets.only(left: 16),
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
              ),
            ),
          )
        ],
      ),
    );
  }
}
