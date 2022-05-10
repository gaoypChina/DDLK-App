import 'package:diadiemlongkhanh/models/remote/body_search/search_model.dart';
import 'package:diadiemlongkhanh/models/remote/place_response/place_response.dart';
import 'package:diadiemlongkhanh/services/api_service/api_client.dart';
import 'package:diadiemlongkhanh/services/di/di.dart';
import 'package:diadiemlongkhanh/services/storage/storage_service.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit() : super(SearchInitialState()) {
    dataSearch = SearchModel(
      pageSize: 10,
      page: _page,
    );
  }
  int _page = 1;
  late SearchModel dataSearch;
  List<PlaceModel> places = [];
  getHistorySearch() async {
    final res = await injector.get<StorageService>().getKeyWords() ?? [];
    emit(SearchGetHistoryDoneState(res));
  }

  searchKeyWord(String v) async {
    dataSearch.keyword = v;
    if (v.isEmpty) {
      places.clear();
      emit(SearchClearKeyWordDoneState());
      getHistorySearch();
      return;
    }
    searchPlaces();
  }

  searchPlaces() async {
    final res = await injector.get<ApiClient>().searchPlaces(
          dataSearch.toJson(),
        );
    print(res);
    if (res != null) {
      places = res.result;
      emit(SearchGetPlacesDoneState());
    }
  }

  saveHistorySearch(String val) {
    injector.get<StorageService>().saveKeyWords(val);
  }
}
