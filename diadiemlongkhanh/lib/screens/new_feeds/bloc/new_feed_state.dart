part of 'new_feed_cubit.dart';

abstract class NewFeedState extends Equatable {
  @override
  List<Object> get props => [const Uuid().v4()];
}

class NewFeedInitialState extends NewFeedState {}

class NewFeedGetDoneState extends NewFeedState {}

class NewFeedLoadingState extends NewFeedState {}
