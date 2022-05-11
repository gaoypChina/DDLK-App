part of 'search_cubit.dart';

abstract class SearchState extends Equatable {
  @override
  List<Object> get props => [const Uuid().v4()];
}

class SearchInitialState extends SearchState {}

class SearchGetHistoryDoneState extends SearchState {
  final List<String> keyWords;
  SearchGetHistoryDoneState(this.keyWords);
}

class SearchGetPlacesDoneState extends SearchState {}

class SearchClearKeyWordDoneState extends SearchState {}

class SearchGetSubCategoriesDoneState extends SearchState {}
