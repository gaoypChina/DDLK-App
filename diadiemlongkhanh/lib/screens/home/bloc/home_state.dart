part of 'home_cubit.dart';

abstract class HomeState extends Equatable {
  @override
  List<Object> get props => [const Uuid().v4()];
}

class HomeInitialState extends HomeState {}

class HomeGetSlideDoneState extends HomeState {
  final List<SlideModel> slides;
  HomeGetSlideDoneState(this.slides);
}

class HomeGetPlaceNearDoneState extends HomeState {
  final List<PlaceModel> places;
  HomeGetPlaceNearDoneState(this.places);
}

class HomeGetPlaceHotDoneState extends HomeState {
  final List<PlaceModel> places;
  HomeGetPlaceHotDoneState(this.places);
}

class HomeGetVouchersDoneState extends HomeState {
  final List<VoucherModel> vouchers;
  HomeGetVouchersDoneState(this.vouchers);
}

class HomeGetSubCategoriesDoneState extends HomeState {
  HomeGetSubCategoriesDoneState();
}

class HomeSelectSubCategoryState extends HomeState {
  HomeSelectSubCategoryState();
}

class HomeGetPlaceNewDoneState extends HomeState {
  final List<PlaceModel> places;
  HomeGetPlaceNewDoneState(this.places);
}

class HomeGetNewFeedsDoneState extends HomeState {
  HomeGetNewFeedsDoneState();
}
