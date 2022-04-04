import 'package:flutter/material.dart';

import 'my_back_button.dart';

class MyAppBar extends StatelessWidget with PreferredSizeWidget {
  final String? title;
  MyAppBar({this.title});
  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: Size.fromHeight(kToolbarHeight),
      child: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          title ?? '',
          style: Theme.of(context).textTheme.headline1,
        ),
        leading: MyBackButton(),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
