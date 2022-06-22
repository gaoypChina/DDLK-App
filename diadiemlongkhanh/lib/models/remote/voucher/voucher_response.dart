import 'package:diadiemlongkhanh/models/remote/place_response/place_response.dart';
import 'package:diadiemlongkhanh/models/remote/result_base/base_response.dart';
import 'package:diadiemlongkhanh/models/remote/thumnail/thumbnail_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'voucher_response.g.dart';

@JsonSerializable()
class VoucherModel extends BaseResponse {
  @JsonKey(name: '_id')
  String? id;
  int? count;
  String? code;
  String? title;
  String? content;
  String? startDate;
  String? endDate;
  PlaceModel? place;
  int? usedCount;
  ThumbnailModel? thumbnail;

  VoucherModel();
  factory VoucherModel.fromJson(Map<String, dynamic> json) =>
      _$VoucherModelFromJson(json);
}
