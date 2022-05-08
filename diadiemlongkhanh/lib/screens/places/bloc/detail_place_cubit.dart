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
  getDetail() async {
    final res = await injector.get<ApiClient>().getDetailPlace(id);
    if (res != null) {
      emit(DetailPlaceGetDoneState(res));
    }
  }
}
