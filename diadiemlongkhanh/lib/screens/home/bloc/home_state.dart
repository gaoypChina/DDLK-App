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
