import 'package:diadiemlongkhanh/resources/asset_constant.dart';
import 'package:diadiemlongkhanh/resources/color_constant.dart';
import 'package:diadiemlongkhanh/routes/router_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_sign_in/google_sign_in.dart';

class ListOptionLoginView extends StatelessWidget {
  final bool isLogin;
  ListOptionLoginView({this.isLogin = true});

  Future<void> _handleSignIn() async {
    GoogleSignIn _googleSignIn = GoogleSignIn(
      scopes: [
        'email',
        'https://www.googleapis.com/auth/contacts.readonly',
      ],
    );
    try {
      final res = await _googleSignIn.signIn();
      print(res);
    } catch (error) {
      print(error);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildOptionButton(
          context,
          icon: SvgPicture.asset(
            ConstantIcons.ic_user,
          ),
          title: 'Sử dụng số điện thoại',
          onPressed: () => Navigator.of(context)
              .pushNamed(isLogin ? RouterName.login : RouterName.signup),
        ),
        SizedBox(
          height: 16,
        ),
        _buildOptionButton(
          context,
          icon: SvgPicture.asset(
            ConstantIcons.ic_fb,
          ),
          title: 'Tiếp tục với Facebook',
        ),
        SizedBox(
          height: 16,
        ),
        _buildOptionButton(
          context,
          onPressed: _handleSignIn,
          icon: SvgPicture.asset(
            ConstantIcons.ic_gg,
          ),
          title: 'Tiếp tục với Google',
        ),
        SizedBox(
          height: 16,
        ),
        _buildOptionButton(
          context,
          icon: SvgPicture.asset(
            ConstantIcons.ic_apple,
          ),
          title: 'Tiếp tục với Apple',
        ),
        SizedBox(
          height: 16,
        ),
      ],
    );
  }

  Widget _buildOptionButton(BuildContext context,
      {required Widget icon, required String title, Function()? onPressed}) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onPressed,
      child: Container(
        height: 48,
        padding: const EdgeInsets.only(left: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          border: Border.all(
            color: ColorConstant.border_gray,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            icon,
            Text(
              title,
              style: Theme.of(context).textTheme.headline2,
            ),
            SizedBox(
              width: 40,
              height: 40,
            ),
          ],
        ),
      ),
    );
  }
}
