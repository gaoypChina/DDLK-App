import 'package:diadiemlongkhanh/models/remote/new_feed/new_feed_response.dart';
import 'package:diadiemlongkhanh/models/remote/result_base/result_base_response.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:diadiemlongkhanh/models/remote/info_paging/info_paging_response.dart';

part 'result_new_feed_response.g.dart';

@JsonSerializable()
class ResultNewFeedModel extends ResultBaseResponse {
  @JsonKey(defaultValue: [])
  late List<NewFeedModel> result;
  ResultNewFeedModel();
  factory ResultNewFeedModel.fromJson(Map<String, dynamic> json) =>
      _$ResultNewFeedModelFromJson(json);
}
