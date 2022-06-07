part of 'account_cubit.dart';

abstract class AccountState extends Equatable {
  @override
  List<Object> get props => [const Uuid().v4()];
}

class AccountInitialState extends AccountState {}

class AccountGetReviewsDoneState extends AccountState {}

class AccountLoadingState extends AccountState {}

class AccountGetStatsDoneState extends AccountState {}

class AccountGetProfileDoneState extends AccountState {}
