import 'package:diadiemlongkhanh/resources/asset_constant.dart';
import 'package:diadiemlongkhanh/resources/color_constant.dart';
import 'package:diadiemlongkhanh/routes/router_manager.dart';
import 'package:diadiemlongkhanh/screens/category/category_screen.dart';
import 'package:diadiemlongkhanh/screens/home/bloc/home_cubit.dart';
import 'package:diadiemlongkhanh/screens/home/home_screen.dart';
import 'package:diadiemlongkhanh/screens/login/option_login_screen.dart';
import 'package:diadiemlongkhanh/screens/new_feeds/bloc/new_feed_cubit.dart';
import 'package:diadiemlongkhanh/screens/new_feeds/new_feed_screen.dart';
import 'package:diadiemlongkhanh/screens/profile/account_screen.dart';
import 'package:diadiemlongkhanh/services/di/di.dart';
import 'package:diadiemlongkhanh/services/storage/storage_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import 'fab_custom/fab_bottom_app_bar.dart';

class BaseTabBarSreen extends StatefulWidget {
  const BaseTabBarSreen({Key? key}) : super(key: key);

  @override
  _BaseTabBarSreenState createState() => _BaseTabBarSreenState();
}

class _BaseTabBarSreenState extends State<BaseTabBarSreen>
    with SingleTickerProviderStateMixin {
  int _indexSelected = 0;
  late TabController _controller;
  String? _token;

  List<Widget> tabs = [];

  @override
  void initState() {
    super.initState();
    _token = injector.get<StorageService>().getToken();
    tabs = [
      BlocProvider(
        create: (_) => HomeCubit(),
        child: HomeScreen(),
      ),
      BlocProvider(
        create: (_) => NewFeedCubit(),
        child: NewFeedScreen(),
      ),
      CategoryScreen(),
      _token != null ? AccountScreen() : OptionLoginScreen(),
    ];
    _controller = new TabController(length: 4, vsync: this);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  _selectedTab(int index) {
    setState(() {
      _indexSelected = index;
      _controller.animateTo(_indexSelected);
    });
  }

  @override
  Widget build(BuildContext context) {
    bool keyboardIsOpened = MediaQuery.of(context).viewInsets.bottom != 0.0;
    print('build');
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        floatingActionButton: Visibility(
          visible: !keyboardIsOpened,
          child: Container(
            width: 70,
            height: 70,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(40),
                boxShadow: [
                  BoxShadow(
                    color: ColorConstant.green_shadow.withOpacity(0.49),
                    blurRadius: 16,
                  )
                ]),
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: FloatingActionButton(
                onPressed: () =>
                    Navigator.of(context).pushNamed(RouterName.create_review),
                backgroundColor: Theme.of(context).primaryColor,
                child: SvgPicture.asset(ConstantIcons.ic_plus),
              ),
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: FABBottomAppBar(
          centerItemText: '',
          selectedColor: Theme.of(context).primaryColor,
          notchedShape: CircularNotchedRectangle(),
          color: ColorConstant.neutral_gray,
          onTabSelected: _selectedTab,
          items: [
            FABBottomAppBarItem(
              iconData: SvgPicture.asset(
                ConstantIcons.ic_home,
                color: _indexSelected == 0
                    ? Theme.of(context).primaryColor
                    : ColorConstant.neutral_gray,
              ),
              text: 'Trang chủ',
            ),
            FABBottomAppBarItem(
              iconData: SvgPicture.asset(
                ConstantIcons.ic_compass,
                color: _indexSelected == 1
                    ? Theme.of(context).primaryColor
                    : ColorConstant.neutral_gray,
              ),
              text: 'Khám phá',
            ),
            FABBottomAppBarItem(
              iconData: SvgPicture.asset(
                ConstantIcons.ic_category,
                color: _indexSelected == 2
                    ? Theme.of(context).primaryColor
                    : ColorConstant.neutral_gray,
              ),
              text: 'Danh mục',
            ),
            FABBottomAppBarItem(
              iconData: SvgPicture.asset(
                ConstantIcons.ic_account,
                color: _indexSelected == 3
                    ? Theme.of(context).primaryColor
                    : ColorConstant.neutral_gray,
              ),
              text: 'Tài khoản',
            ),
          ],
        ),
        body: TabBarView(
          controller: _controller,
          physics: NeverScrollableScrollPhysics(),
          children: tabs,
        ),
      ),
    );
  }
}
