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
import 'package:map_launcher/map_launcher.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';
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

  openMap() async {
    final lat = place?.address?.geo?.lat;
    final long = place?.address?.geo?.long;
    if (await MapLauncher.isMapAvailable(MapType.google) ?? false) {
      await MapLauncher.showMarker(
        mapType: MapType.google,
        coords: Coords(lat ?? 0, long ?? 0),
        title: '',
        description: '',
      );
    } else {
      String googleUrl =
          'https://www.google.com/maps/search/?api=1&query=$lat,$long';
      if (await canLaunchUrlString(googleUrl)) {
        await launchUrlString(googleUrl);
      } else {
        throw 'Could not open the map.';
      }
    }
  }

  sharePlace() async {
    if (place == null) {
      return;
    }
    final url = AppUtils.getPlaceUrl(place!.slug ?? '');
    Share.share(url);
  }

  _unsavePlace(BuildContext context) async {
    AppUtils.showLoading();
    final res = await injector.get<ApiClient>().unsavePlace(id);
    AppUtils.hideLoading();
    if (res != null) {
      if (res.error != null) {
        AppUtils.showOkDialog(context, res.error!);
        return;
      }
      place?.isSaved = false;
      emit(DetailPlaceSaveState());
      AppUtils.showOkDialog(context, 'Bỏ lưu địa điểm thành công!');
      return;
    }
    AppUtils.showOkDialog(context, ConstantTitle.please_try_again);
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
    if (place?.isSaved == true) {
      _unsavePlace(context);
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
      place?.isSaved = true;
      emit(DetailPlaceSaveState());
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
        reviews.forEach((e) {
          e.controller = TextEditingController();
        });
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

  sendComment(
    BuildContext context,
    int index,
  ) async {
    if (reviews[index].controller?.text == '') {
      return;
    }
    final token = await injector.get<StorageService>().getToken();
    if (token == null) {
      Navigator.of(context).pushNamed(
        RouterName.option_login,
        arguments: true,
      );
      return;
    }
    final data = {
      'review': reviews[index].id,
      'content': reviews[index].controller?.text ?? '',
    };
    final res = await injector.get<ApiClient>().commentReview(data);
    if (res != null) {
      reviews[index].commentCount += 1;
      reviews[index].controller?.text = '';
      emit(DetailPlaceGetReviewsDoneState());
    }
  }

  addReview(
    BuildContext context,
  ) async {
    final token = await injector.get<StorageService>().getToken();
    if (token == null) {
      Navigator.of(context).pushNamed(
        RouterName.option_login,
        arguments: true,
      );
      return;
    }
    Navigator.of(context).pushNamed(
      RouterName.create_review,
      arguments: place,
    );
  }

  likePost(
    BuildContext context,
    int index,
  ) async {
    final token = await injector.get<StorageService>().getToken();
    if (token == null) {
      Navigator.of(context).pushNamed(
        RouterName.option_login,
        arguments: true,
      );
      return;
    }
    if (!reviews[index].isLiked) {
      final res =
          await injector.get<ApiClient>().likeReview(reviews[index].id ?? '');
      if (res != null && res.success == true) {
        reviews[index].isLiked = true;
        reviews[index].likeCount += 1;
        emit(DetailPlaceGetReviewsDoneState());
      }
    } else {
      final res =
          await injector.get<ApiClient>().unLikeReview(reviews[index].id ?? '');
      if (res != null && res.success == true) {
        reviews[index].isLiked = false;
        reviews[index].likeCount -= 1;
        emit(DetailPlaceGetReviewsDoneState());
      }
    }
  }
}
