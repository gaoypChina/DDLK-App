import 'package:json_annotation/json_annotation.dart';

part 'social_model.g.dart';

@JsonSerializable()
class SocialModel {
  String? name;
  String? link;
  SocialModel();
  factory SocialModel.fromJson(Map<String, dynamic> json) =>
      _$SocialModelFromJson(json);
}
