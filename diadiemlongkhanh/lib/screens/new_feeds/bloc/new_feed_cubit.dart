import 'package:diadiemlongkhanh/models/remote/new_feed/new_feed_response.dart';
import 'package:diadiemlongkhanh/services/api_service/api_client.dart';
import 'package:diadiemlongkhanh/services/di/di.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';

part 'new_feed_state.dart';

class NewFeedCubit extends Cubit<NewFeedState> {
  NewFeedCubit() : super(NewFeedInitialState());
  int page = 1;
  List<NewFeedModel> newfeeds = [];
  getNewFeeds() async {
    final res = await injector.get<ApiClient>().getExplores();
    if (res != null) {
      newfeeds = res.result;
      emit(NewFeedGetDoneState());
    }
  }
}
