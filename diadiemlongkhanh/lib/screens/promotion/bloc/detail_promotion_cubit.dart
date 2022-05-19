import 'package:diadiemlongkhanh/models/remote/voucher/voucher_response.dart';
import 'package:diadiemlongkhanh/services/api_service/api_client.dart';
import 'package:diadiemlongkhanh/services/di/di.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';

part 'detail_promotion_state.dart';

class DetailPromotionCubit extends Cubit<DetailPromotionState> {
  DetailPromotionCubit({this.id}) : super(DetailPromotionInitialState());

  final String? id;
  VoucherModel? voucher;
  getDetailVoucher() async {
    final res = await injector.get<ApiClient>().getDetailVoucher(id ?? '');
    if (res != null) {
      voucher = res;
      emit(DetailPromotionGetDoneState());
    }
  }
}
