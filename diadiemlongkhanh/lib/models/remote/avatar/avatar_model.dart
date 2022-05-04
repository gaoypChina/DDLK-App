import 'package:json_annotation/json_annotation.dart';

part 'avatar_model.g.dart';

@JsonSerializable()
class AvatarModel {
  @JsonKey(name: '_id')
  String? id;
  String? path;
  AvatarModel();
  factory AvatarModel.fromJson(Map<String, dynamic> json) =>
      _$AvatarModelFromJson(json);
}
