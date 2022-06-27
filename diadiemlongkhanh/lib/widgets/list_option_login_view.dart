import 'package:diadiemlongkhanh/resources/app_constant.dart';
import 'package:diadiemlongkhanh/resources/asset_constant.dart';
import 'package:diadiemlongkhanh/resources/color_constant.dart';
import 'package:diadiemlongkhanh/routes/router_manager.dart';
import 'package:diadiemlongkhanh/services/api_service/api_client.dart';
import 'package:diadiemlongkhanh/services/di/di.dart';
import 'package:diadiemlongkhanh/services/storage/storage_service.dart';
import 'package:diadiemlongkhanh/utils/app_utils.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_sign_in/google_sign_in.dart';

class ListOptionLoginView extends StatelessWidget {
  final bool isLogin;
  ListOptionLoginView({this.isLogin = true});

  Future<void> _handleSignIn(BuildContext context) async {
    GoogleSignIn _googleSignIn = GoogleSignIn(
      scopes: [
        'email',
      ],
    );
    _googleSignIn.signIn().then((result) {
      result?.authentication.then((googleKey) {
        print(googleKey.accessToken);
        print(googleKey.idToken);
        print(_googleSignIn.currentUser?.displayName);
        if (_googleSignIn.currentUser != null) {
          _loginWithGoogle(context, _googleSignIn.currentUser!);
        }
      }).catchError((err) {
        print('inner error');
      });
    }).catchError((err) {
      print('error occured');
    });
  }

  _loginWithGoogle(
    BuildContext context,
    GoogleSignInAccount account,
  ) async {
    final data = {
      "displayName": account.displayName,
      "email": account.email,
      "id": account.id,
      "photoUrl": account.photoUrl,
    };
    AppUtils.showLoading();
    final res = await injector.get<ApiClient>().loginWithGoogle(data);
    AppUtils.hideLoading();
    if (res != null) {
      if (res.error != null) {
        AppUtils.showOkDialog(context, res.error!);
        return;
      }
      if (res.token != null) {
        await injector.get<StorageService>().saveToken(res.token!);
        // await _getInfoUser();
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
          onPressed: () => _handleSignIn(context),
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
