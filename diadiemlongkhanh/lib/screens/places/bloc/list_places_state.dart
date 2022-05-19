part of 'list_places_cubit.dart';

abstract class ListPlacesState extends Equatable {
  @override
  List<Object> get props => [const Uuid().v4()];
}

class ListPlacesInitialState extends ListPlacesState {}

class ListPlacesGetDoneState extends ListPlacesState {}
