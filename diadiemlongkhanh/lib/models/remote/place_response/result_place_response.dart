import 'package:diadiemlongkhanh/models/remote/place_response/place_response.dart';
import 'package:diadiemlongkhanh/models/remote/result_base/result_base_response.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:diadiemlongkhanh/models/remote/info_paging/info_paging_response.dart';

part 'result_place_response.g.dart';

@JsonSerializable()
class ResultPlaceModel extends ResultBaseResponse {
  @JsonKey(defaultValue: [])
  late List<PlaceModel> result;
  ResultPlaceModel();
  factory ResultPlaceModel.fromJson(Map<String, dynamic> json) =>
      _$ResultPlaceModelFromJson(json);
}
