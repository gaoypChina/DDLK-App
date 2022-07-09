import 'package:diadiemlongkhanh/models/remote/body_search/search_model.dart';
import 'package:diadiemlongkhanh/models/remote/category/category_response.dart';
import 'package:diadiemlongkhanh/models/remote/place_response/place_response.dart';
import 'package:diadiemlongkhanh/services/api_service/api_client.dart';
import 'package:diadiemlongkhanh/services/di/di.dart';
import 'package:diadiemlongkhanh/utils/global_value.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';

part 'list_places_state.dart';

class ListPlacesCubit extends Cubit<ListPlacesState> {
  ListPlacesCubit({
    this.subCategory,
    this.category,
    this.nearMe = false,
  }) : super(ListPlacesInitialState()) {
    dataSearch = SearchModel(
      pageSize: 20,
      page: _page,
      subCategories: subCategory != null && subCategory!.id != ''
          ? [subCategory!.id!]
          : [],
      categories: category != null ? [category!.id!] : [],
      lat: GlobalValue.lat,
      long: GlobalValue.long,
    );
  }
  List<PlaceModel> places = [];
  int _page = 1;
  bool isLast = true;
  bool nearMe;
  final CategoryModel? subCategory;
  final CategoryModel? category;
  List<CategoryModel> categories = [];
  bool isLoading = false;

  late SearchModel dataSearch;
  searchPlaces() async {
    dataSearch.nearby = nearMe ? 'me' : '';
    try {
      final res = await injector.get<ApiClient>().searchPlaces(
            dataSearch.toJson(),
          );
      isLoading = false;
      print(res);
      if (res != null) {
        if (_page == 1) {
          places = res.result;
        } else {
          places.addAll(res.result);
        }
        isLast = res.info?.total == places.length;
        emit(ListPlacesGetDoneState());
      }
    } catch (error) {
      print(error);
    }
  }

  loadMore() async {
    // if (isLoading) {
    //   return;
    // }
    // isLoading = true;
    if (isLast) {
      return;
    }
    _page += 1;
    dataSearch.page = _page;
    searchPlaces();
  }

  typingKeyword() {
    emit(ListPlacesLoadingState());
  }

  filterComplete(SearchModel data) {
    nearMe = data.nearby != '';
    dataSearch.opening = data.opening;
    dataSearch.price = data.price;
    dataSearch.categories = data.categories;
    dataSearch.subCategories = data.subCategories;
    if (nearMe) {
      dataSearch.lat = GlobalValue.lat;
      dataSearch.long = GlobalValue.long;
    } else {
      dataSearch.lat = null;
      dataSearch.long = null;
    }
    _page = 1;
    dataSearch.page = _page;
    searchPlaces();
  }

  getCategories() async {
    final res = await injector.get<ApiClient>().getCategories();
    if (res != null) {
      categories = res;
    }
  }

  searchKeyWord(String v) async {
    dataSearch.keyword = v;
    _page = 1;
    dataSearch.page = _page;
    searchPlaces();
  }
}
