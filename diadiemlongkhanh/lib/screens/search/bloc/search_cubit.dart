import 'package:diadiemlongkhanh/models/remote/body_search/search_model.dart';
import 'package:diadiemlongkhanh/models/remote/category/category_response.dart';
import 'package:diadiemlongkhanh/models/remote/place_response/place_response.dart';
import 'package:diadiemlongkhanh/services/api_service/api_client.dart';
import 'package:diadiemlongkhanh/services/di/di.dart';
import 'package:diadiemlongkhanh/services/storage/storage_service.dart';
import 'package:diadiemlongkhanh/utils/global_value.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit() : super(SearchInitialState()) {
    dataSearch = SearchModel(
      pageSize: 5,
      page: _page,
      lat: GlobalValue.lat,
      long: GlobalValue.long,
    );
  }
  int _page = 1;
  bool isLast = true;
  late SearchModel dataSearch;
  List<PlaceModel> places = [];
  List<PlaceModel> hotPlaces = [];
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

  typingKeyWord() {
    emit(SearchPlacesLoadingState());
  }

  searchKeyWord(String v) async {
    dataSearch.keyword = v;
    _page = 1;
    dataSearch.page = _page;
    if (v.isEmpty) {
      places.clear();
      emit(SearchClearKeyWordDoneState());
      getHistorySearch();
      return;
    }
    searchPlaces();
  }

  getPlacesHot() async {
    final res = await injector.get<ApiClient>().getPlacesHot();
    if (res != null) {
      hotPlaces = res;
      emit(
        SearchPlacesGetHotDoneState(),
      );
    }
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
      if (_page == 1) {
        places = res.result;
      } else {
        places.addAll(res.result);
      }

      isLast = res.info?.total == places.length;
      emit(SearchGetPlacesDoneState());
    }
  }

  filterComplete(SearchModel data) {
    dataSearch.nearby = data.nearby;
    dataSearch.opening = data.opening;
    dataSearch.price = data.price;
    dataSearch.categories = data.categories;
    dataSearch.subCategories = data.subCategories;
    _page = 1;
    dataSearch.page = _page;
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

  searchPlaceWithSubCategory(CategoryModel subCategory) async {
    final subCateSelected = [subCategory.id ?? ''];
    dataSearch.subCategories = subCateSelected;
    final res = await injector.get<ApiClient>().searchPlaces(
          dataSearch.toJson(),
        );
    print(res);
    if (res != null) {
      places = res.result;
      emit(SearchGetPlacesDoneState());
    }
  }

  loadMore() async {
    _page += 1;
    dataSearch.page = _page;
    searchPlaces();
  }

  saveHistorySearch(String val) {
    if (val.isEmpty) return;
    injector.get<StorageService>().saveKeyWords(val);
  }
}
