import 'package:diadiemlongkhanh/models/remote/body_search/search_model.dart';
import 'package:diadiemlongkhanh/models/remote/category/category_response.dart';
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
  List<CategoryModel> subCategories = [];
  List<CategoryModel> categories = [];
  getHistorySearch() async {
    final res = await injector.get<StorageService>().getKeyWords() ?? [];
    emit(SearchGetHistoryDoneState(res));
  }

  getCategories() async {
    final res = await injector.get<ApiClient>().getCategories();
    if (res != null) {
      categories = res;
    }
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

  deleteKeyWord(String val) async {
    await injector.get<StorageService>().deleteKeyWord(val);
    getHistorySearch();
  }

  deleteAllKeyWords() async {
    await injector.get<StorageService>().deleteAllKeyWords();
    getHistorySearch();
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

  filterComplete(SearchModel data) {
    dataSearch.nearby = data.nearby;
    dataSearch.opening = data.opening;
    dataSearch.price = data.price;
    searchPlaces();
  }

  getSubCategories() async {
    final res = await injector.get<ApiClient>().getSubCategories();
    if (res != null) {
      subCategories = res;
      if (subCategories.length > 0) {
        final total = CategoryModel();
        total.id = '';
        total.name = 'Tất cả';
        subCategories.insert(0, total);
      }
      emit(SearchGetSubCategoriesDoneState());
    }
  }

  saveHistorySearch(String val) {
    if (val.isEmpty) return;
    injector.get<StorageService>().saveKeyWords(val);
  }
}
