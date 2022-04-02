import 'package:diadiemlongkhanh/widgets/my_back_button.dart';
import 'package:diadiemlongkhanh/widgets/segment_login_view.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
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
            SegmentLoginView(),
            Container()
          ],
        ),
      ),
    );
  }
}
