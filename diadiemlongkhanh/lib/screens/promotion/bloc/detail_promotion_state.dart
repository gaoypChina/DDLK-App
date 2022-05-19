part of 'detail_promotion_cubit.dart';

abstract class DetailPromotionState extends Equatable {
  @override
  List<Object> get props => [const Uuid().v4()];
}

class DetailPromotionInitialState extends DetailPromotionState {}

class DetailPromotionGetDoneState extends DetailPromotionState {}
