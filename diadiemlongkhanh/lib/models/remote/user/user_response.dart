import 'package:diadiemlongkhanh/models/remote/place_response/place_response.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_response.g.dart';

@JsonSerializable()
class UserModel {
  @JsonKey(name: '_id')
  String? id;
  String? role;
  String? avatar;
  String? name;
  String? username;
  int? savedCount;
  bool? gender;
  String? email;
  SocialModel? social;
  String? phone;
  String? birth;
  @JsonKey(defaultValue: false)
  late bool isFollowed;
  DateTime? createdAt;

  UserModel();
  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);
}
