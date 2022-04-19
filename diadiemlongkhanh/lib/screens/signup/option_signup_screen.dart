import 'package:diadiemlongkhanh/resources/asset_constant.dart';
import 'package:diadiemlongkhanh/widgets/list_option_login_view.dart';
import 'package:diadiemlongkhanh/widgets/my_appbar.dart';
import 'package:diadiemlongkhanh/widgets/my_back_button.dart';
import 'package:flutter/material.dart';

class OptionSingupScreen extends StatefulWidget {
  const OptionSingupScreen({Key? key}) : super(key: key);

  @override
  _OptionSingupScreenState createState() => _OptionSingupScreenState();
}

class _OptionSingupScreenState extends State<OptionSingupScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: MyAppBar(
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
              SizedBox(
                height: 28,
              ),
              Text(
                'Đăng ký',
                style: Theme.of(context).textTheme.headline1,
              ),
              SizedBox(
                height: 8,
              ),
              Text(
                'Đăng nhập để theo dõi bài viết và thông báo,\nlorem isum lorem isum lorem isum',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.subtitle1,
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 16,
                  right: 16,
                  top: 36,
                ),
                child: ListOptionLoginView(
                  isLogin: false,
                ),
              ),
              SizedBox(
                height: 36,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Bạn đã có tài khoản ?',
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  GestureDetector(
                    onTap: () => Navigator.of(context).pop(),
                    child: Text(
                      ' Đăng nhập',
                      style: Theme.of(context).textTheme.headline2?.apply(
                            color: Theme.of(context).primaryColor,
                          ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 36,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
