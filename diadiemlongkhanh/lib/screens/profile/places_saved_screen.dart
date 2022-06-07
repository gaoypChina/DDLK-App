import 'package:diadiemlongkhanh/resources/color_constant.dart';
import 'package:diadiemlongkhanh/screens/profile/bloc/account_cubit.dart';
import 'package:diadiemlongkhanh/services/api_service/api_client.dart';
import 'package:diadiemlongkhanh/services/di/di.dart';
import 'package:diadiemlongkhanh/utils/global_value.dart';
import 'package:diadiemlongkhanh/widgets/my_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PlacesSavedScreen extends StatefulWidget {
  const PlacesSavedScreen({Key? key}) : super(key: key);

  @override
  State<PlacesSavedScreen> createState() => _PlacesSavedScreenState();
}

class _PlacesSavedScreenState extends State<PlacesSavedScreen> {
  AccountCubit get _cubit => BlocProvider.of(context);
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      _getPlacesSaved();
    });
  }

  _getPlacesSaved() async {
    final res = injector.get<ApiClient>().getPlacesSaved(GlobalValue.id ?? '');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstant.grey_F2F4F8,
      appBar: MyAppBar(title: 'Địa điểm đã lưu'),
    );
  }
}
