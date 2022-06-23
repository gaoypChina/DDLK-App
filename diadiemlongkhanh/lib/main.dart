import 'dart:async';
import 'dart:io';
import 'package:diadiemlongkhanh/app/app_profile_cubit.dart';
import 'package:diadiemlongkhanh/config/env_config.dart';
import 'package:diadiemlongkhanh/resources/color_constant.dart';
import 'package:diadiemlongkhanh/routes/router_manager.dart';
import 'package:diadiemlongkhanh/services/api_service/api_client.dart';
import 'package:diadiemlongkhanh/services/di/di.dart';
import 'package:diadiemlongkhanh/services/notification/notification_manager.dart';
import 'package:diadiemlongkhanh/services/storage/storage_service.dart';
import 'package:diadiemlongkhanh/themes/themes.dart';
import 'package:diadiemlongkhanh/utils/global_value.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  // FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  Environment().initConfig(Environment.DEV);

  HttpOverrides.global = MyHttpOverrides();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
      statusBarColor: Colors.white, // Color for Android
      statusBarBrightness:
          Brightness.light // Dark == white status bar -- for IOS.
      ));
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runZonedGuarded(() async {
    await Firebase.initializeApp();
    await NotificationsManager().init();
    await DependencyInjection.inject();

    runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (_) => AppTheme(),
          ),
          BlocProvider(
            create: (_) => AppProfileCubit(),
          )
        ],
        child: MyApp(),
      ),
    );
  }, (e, stack) {
    print(e);
  });
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
  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
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
    // FlutterNativeSplash.remove();
    handleFirebaseMessage();
    _requestLocation();
  }

  handleFirebaseMessage() {
    if (Platform.isAndroid) {
      var initializationSettingsAndroid =
          new AndroidInitializationSettings('@mipmap/ic_launcher');

      var initializationSettings =
          new InitializationSettings(android: initializationSettingsAndroid);
      flutterLocalNotificationsPlugin = new FlutterLocalNotificationsPlugin();
      flutterLocalNotificationsPlugin.initialize(
        initializationSettings,
      );
      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        RemoteNotification? notification = message.notification;
        AndroidNotification? android = message.notification?.android;
        if (notification != null && android != null) {
          flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                channel.id,
                channel.name,
                channelDescription: channel.description,
              ),
            ),
          );
        }
      });
    }
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
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('vi'),
      ],
      theme: AppTheme.of(context, listen: true).currentTheme,
      onGenerateRoute: RouterManager.generateRoute,
      initialRoute: injector.get<StorageService>().getFirstInstall() == null
          ? RouterName.welcome
          : RouterName.base_tabbar,
      builder: EasyLoading.init(),
    );
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..maxConnectionsPerHost = 5
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
