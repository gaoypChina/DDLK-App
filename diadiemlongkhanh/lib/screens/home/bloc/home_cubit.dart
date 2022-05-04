import 'package:diadiemlongkhanh/models/remote/place_response/place_response.dart';
import 'package:diadiemlongkhanh/models/remote/slide/slide_response.dart';
import 'package:diadiemlongkhanh/services/api_service/api_client.dart';
import 'package:diadiemlongkhanh/services/di/di.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitialState());

  getSlides() async {
    final res = await injector.get<ApiClient>().getSlides();
    if (res != null) {
      emit(HomeGetSlideDoneState(res));
    }
  }

  getPlacesNear() async {
    final res = await injector.get<ApiClient>().getPlacesNear(
          10.9238253,
          107.1943696,
          5,
        );
    if (res != null) {
      emit(HomeGetPlaceNearDoneState(res));
    }
  }
}
