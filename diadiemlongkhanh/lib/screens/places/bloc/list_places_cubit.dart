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
      pageSize: 10,
      page: _page,
      lat: GlobalValue.lat,
      long: GlobalValue.long,
    );
  }
  List<PlaceModel> places = [];
  int _page = 1;
  bool nearMe;
  final CategoryModel? subCategory;
  final CategoryModel? category;
  List<CategoryModel> categories = [];

  late SearchModel dataSearch;
  searchPlaces() async {
    if (subCategory != null && subCategory?.id != '') {
      dataSearch.subCategories = [subCategory!.id ?? ''];
    }
    if (category != null && category?.id != '') {
      dataSearch.categories = [category!.id ?? ''];
    }
    dataSearch.nearby = nearMe ? 'me' : '';
    final res = await injector.get<ApiClient>().searchPlaces(
          dataSearch.toJson(),
        );
    print(res);
    if (res != null) {
      places = res.result;
      emit(ListPlacesGetDoneState());
    }
  }

  filterComplete(SearchModel data) {
    dataSearch.nearby = data.nearby;
    dataSearch.opening = data.opening;
    dataSearch.price = data.price;
    dataSearch.categories = data.categories;
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
    searchPlaces();
  }
}
