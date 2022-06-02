import 'package:diadiemlongkhanh/models/remote/new_feed/new_feed_response.dart';
import 'package:diadiemlongkhanh/models/remote/place_response/place_response.dart';
import 'package:diadiemlongkhanh/resources/app_constant.dart';
import 'package:diadiemlongkhanh/routes/router_manager.dart';
import 'package:diadiemlongkhanh/services/api_service/api_client.dart';
import 'package:diadiemlongkhanh/services/di/di.dart';
import 'package:diadiemlongkhanh/services/storage/storage_service.dart';
import 'package:diadiemlongkhanh/utils/app_utils.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:uuid/uuid.dart';

part 'detail_place_state.dart';

class DetailPlaceCubit extends Cubit<DetailPlaceState> {
  DetailPlaceCubit(this.id) : super(DetailPlaceInitalState());
  String id;
  List<NewFeedModel> reviews = [];
  PlaceModel? place;
  bool isVisible = false;
  bool isVisibleAppBar = true;
  int currentIndex = 0;
  getDetail() async {
    try {
      final res = await injector.get<ApiClient>().getDetailPlace(id);
      if (res != null) {
        place = res;
        emit(DetailPlaceGetDoneState(res));
      }
    } catch (error) {
      print(error);
    }
  }

  savePlace(BuildContext context) async {
    final token = await injector.get<StorageService>().getToken();
    if (token == null) {
      Navigator.of(context).pushNamed(
        RouterName.option_login,
        arguments: true,
      );
      return;
    }
    AppUtils.showLoading();
    final res = await injector.get<ApiClient>().savePlace(id);
    AppUtils.hideLoading();
    if (res != null) {
      if (res.error != null) {
        AppUtils.showOkDialog(context, res.error!);
        return;
      }
      AppUtils.showOkDialog(context, 'Lưu địa điểm thành công!');
      return;
    }
    AppUtils.showOkDialog(context, ConstantTitle.please_try_again);
  }

  showAppBar(bool visible) {
    isVisibleAppBar = visible;
    emit(DetailPlaceShowAppBarState());
  }

  showMenu(bool visible) {
    isVisible = visible;
    emit(DetailPlaceShowMenuState());
  }

  selectMenu(int index) {
    currentIndex = index;
    emit(DetailPlaceSelectMenuState());
  }

  Future<void> makePhoneCall() async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: place?.phone ?? '',
    );
    await launchUrl(launchUri);
  }

  getReviews() async {
    try {
      final res = await injector.get<ApiClient>().getReviewsOfPlace(id);
      if (res != null) {
        reviews = res.result;
        emit(DetailPlaceGetReviewsDoneState());
      }
    } catch (error) {
      print(error);
    }
  }

  changePage(int index) {
    emit(DetailPlaceChangePagePhotoState(index));
  }

  String getRatingTitle(String key) {
    switch (key) {
      case 'position':
        return 'Vị trí';
      case 'view':
        return 'Không gian';
      case 'Đồ uống':
        return 'Không gian';
      case 'service':
        return 'Phục vụ';
      case 'price':
        return 'Giá cả';
    }
    return '';
  }
}
