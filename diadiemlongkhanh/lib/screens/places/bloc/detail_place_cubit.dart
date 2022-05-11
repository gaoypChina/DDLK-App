import 'package:diadiemlongkhanh/models/remote/new_feed/new_feed_response.dart';
import 'package:diadiemlongkhanh/models/remote/place_response/place_response.dart';
import 'package:diadiemlongkhanh/services/api_service/api_client.dart';
import 'package:diadiemlongkhanh/services/di/di.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';

part 'detail_place_state.dart';

class DetailPlaceCubit extends Cubit<DetailPlaceState> {
  DetailPlaceCubit(this.id) : super(DetailPlaceInitalState());
  String id;
  List<NewFeedModel> reviews = [];
  PlaceModel? place;
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
