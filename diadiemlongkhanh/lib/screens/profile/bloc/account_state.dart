part of 'account_cubit.dart';

abstract class AccountState extends Equatable {
  @override
  List<Object> get props => [const Uuid().v4()];
}
