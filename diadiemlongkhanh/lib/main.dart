import 'dart:async';

import 'package:diadiemlongkhanh/config/env_config.dart';
import 'package:diadiemlongkhanh/resources/color_constant.dart';
import 'package:diadiemlongkhanh/routes/router_manager.dart';
import 'package:diadiemlongkhanh/services/di/di.dart';
import 'package:diadiemlongkhanh/themes/themes.dart';
import 'package:diadiemlongkhanh/utils/global_value.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Environment().initConfig(Environment.DEV);
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runZonedGuarded(() async {
    await DependencyInjection.inject();

    runApp(
      ChangeNotifierProvider(
        create: (_) => AppTheme(),
        child: MyApp(),
      ),
    );
  }, (e, stack) {});
  configLoading();
}

void configLoading() {
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 2000)
    ..indicatorType = EasyLoadingIndicatorType.ring
    ..loadingStyle = EasyLoadingStyle.custom
    ..indicatorSize = 45.0
    ..radius = 10.0
    ..progressColor = Colors.yellow
    ..backgroundColor = Colors.white
    ..indicatorColor = ColorConstant.green_primary
    ..textColor = Colors.yellow
    ..userInteractions = false
    ..maskColor = Colors.blue.withOpacity(0.5)
    ..dismissOnTap = false;
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  AppTheme? _theme;
  LocationData? _locationData;
  @override
  void didChangeDependencies() {
    if (_theme == null) {
      _theme = AppTheme.of(context);
    }

    super.didChangeDependencies();
  }

  @override
  void initState() {
    super.initState();
    _requestLocation();
  }

  _requestLocation() async {
    Location location = new Location();

    bool _serviceEnabled;
    PermissionStatus _permissionGranted;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    _locationData = await location.getLocation();
    print(_locationData?.latitude);
    print(_locationData?.longitude);
    GlobalValue.lat = _locationData?.latitude;
    GlobalValue.long = _locationData?.longitude;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: AppTheme.of(context, listen: true).currentTheme,
      onGenerateRoute: RouterManager.generateRoute,
      initialRoute: RouterName.base_tabbar,
      builder: EasyLoading.init(),
    );
  }
}
