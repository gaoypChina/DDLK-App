import 'package:flutter/material.dart';

import 'my_back_button.dart';

class MyAppBar extends StatelessWidget with PreferredSizeWidget {
  final String? title;
  final bool isShowBackButton;
  MyAppBar({
    this.title,
    this.isShowBackButton = true,
  });
  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: Size.fromHeight(kToolbarHeight),
      child: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: isShowBackButton,
        elevation: 0,
        title: Text(
          title ?? '',
          style: Theme.of(context).textTheme.headline1,
        ),
        leading: isShowBackButton ? MyBackButton() : null,
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
