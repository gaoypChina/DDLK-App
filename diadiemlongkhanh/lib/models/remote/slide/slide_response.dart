import 'package:json_annotation/json_annotation.dart';

part 'slide_response.g.dart';

@JsonSerializable()
class SlideModel {
  @JsonKey(name: '_id')
  String? id;
  int? order;
  String? name;
  PhotoModel? photo;
  String? docModel;
  String? doc;

  SlideModel();
  factory SlideModel.fromJson(Map<String, dynamic> json) =>
      _$SlideModelFromJson(json);
}

@JsonSerializable()
class PhotoModel {
  @JsonKey(name: '_id')
  String? id;
  String? path;

  PhotoModel();
  factory PhotoModel.fromJson(Map<String, dynamic> json) =>
      _$PhotoModelFromJson(json);
}
