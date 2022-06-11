part of 'detail_place_cubit.dart';

abstract class DetailPlaceState extends Equatable {
  @override
  List<Object> get props => [const Uuid().v4()];
}

class DetailPlaceInitalState extends DetailPlaceState {}

class DetailPlaceGetDoneState extends DetailPlaceState {
  final PlaceModel place;
  DetailPlaceGetDoneState(this.place);
}

class DetailPlaceGetReviewsDoneState extends DetailPlaceState {}

class DetailPlaceChangePagePhotoState extends DetailPlaceState {
  final int index;
  DetailPlaceChangePagePhotoState(this.index);
}

class DetailPlaceShowAppBarState extends DetailPlaceState {
  DetailPlaceShowAppBarState();
}

class DetailPlaceShowMenuState extends DetailPlaceState {
  DetailPlaceShowMenuState();
}

class DetailPlaceSelectMenuState extends DetailPlaceState {
  DetailPlaceSelectMenuState();
}

class DetailPlaceSaveState extends DetailPlaceState {}
