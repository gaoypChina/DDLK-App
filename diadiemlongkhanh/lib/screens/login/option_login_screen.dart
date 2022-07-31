import 'package:diadiemlongkhanh/resources/asset_constant.dart';
import 'package:diadiemlongkhanh/resources/color_constant.dart';
import 'package:diadiemlongkhanh/routes/router_manager.dart';
import 'package:diadiemlongkhanh/widgets/list_option_login_view.dart';
import 'package:diadiemlongkhanh/widgets/my_appbar.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

class OptionLoginScreen extends StatefulWidget {
  const OptionLoginScreen({
    Key? key,
    this.isBack = false,
  }) : super(key: key);
  final bool isBack;

  @override
  _OptionLoginScreenState createState() => _OptionLoginScreenState();
}

class _OptionLoginScreenState extends State<OptionLoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: MyAppBar(
        isShowBackButton: widget.isBack,
        isShowBgBackButton: true,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                ConstantImages.logo,
                width: 144,
                height: 144,
              ),
              const SizedBox(
                height: 28,
              ),
              Text(
                'Đăng nhập',
                style: Theme.of(context).textTheme.headline1,
              ),
              const SizedBox(
                height: 8,
              ),
              Text(
                'Đăng nhập để theo dõi bài viết và thông báo',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.subtitle1,
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 16,
                  right: 16,
                  top: 36,
                ),
                child: ListOptionLoginView(),
              ),
              const SizedBox(
                height: 36,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Bạn chưa có tài khoản ?',
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  GestureDetector(
                    onTap: () =>
                        Navigator.of(context).pushNamed(RouterName.signup),
                    child: Text(
                      ' Đăng ký',
                      style: Theme.of(context).textTheme.headline2?.apply(
                            color: Theme.of(context).primaryColor,
                          ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: openLink,
                child: const Text(
                  'Chính sách bảo mật',
                  style: TextStyle(
                    fontSize: 12,
                    color: ColorConstant.neutral_black,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
              const SizedBox(
                height: 36,
              ),
            ],
          ),
        ),
      ),
    );
  }

  openLink() async {
    const url = "https://diadiemlongkhanh.com/privacy";
    if (await canLaunchUrlString(url)) {
      await launchUrlString(url);
    } else {
      throw "Could not launch $url";
    }
  }
}
