import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';
part 'app_profile_state.dart';

class AppProfileCubit extends Cubit<AppProfileState> {
  AppProfileCubit() : super(AppProfileInitalState());
  updateProfile() {
    emit(AppProfileUpdateState());
  }
}
