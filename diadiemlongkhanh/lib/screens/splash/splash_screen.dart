import 'package:diadiemlongkhanh/resources/asset_constant.dart';
import 'package:diadiemlongkhanh/routes/router_manager.dart';
import 'package:diadiemlongkhanh/screens/home/bloc/home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  HomeCubit get _cubit => BlocProvider.of(context);
  @override
  void initState() {
    super.initState();
    _cubit.getAllData();
    Future.delayed(
      Duration(seconds: 3),
      () => Navigator.of(context).pushNamedAndRemoveUntil(
        RouterName.base_tabbar,
        (route) => false,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Image.asset(
          ConstantImages.logo2,
          width: 200,
          height: 200,
        ),
      ),
    );
  }
}
