part of 'app_profile_cubit.dart';

abstract class AppProfileState extends Equatable {
  @override
  List<Object> get props => [const Uuid().v4()];
}

class AppProfileInitalState extends AppProfileState {}

class AppProfileUpdateState extends AppProfileState {}
