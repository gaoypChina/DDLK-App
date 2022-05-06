import 'package:json_annotation/json_annotation.dart';

part 'info_paging_response.g.dart';

@JsonSerializable()
class InfoPagingModel {
  @JsonKey(defaultValue: 0)
  late int current;
  @JsonKey(defaultValue: 0)
  late int pageSize;
  @JsonKey(defaultValue: 0)
  late int total;

  InfoPagingModel();
  factory InfoPagingModel.fromJson(Map<String, dynamic> json) =>
      _$InfoPagingModelFromJson(json);
}
