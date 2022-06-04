import 'package:diadiemlongkhanh/models/remote/base/auth_response.dart';
import 'package:diadiemlongkhanh/models/remote/user/user_response.dart';
import 'package:json_annotation/json_annotation.dart';

part 'info_user_response.g.dart';

@JsonSerializable()
class InfoUserResponse extends AuthResponse {
  UserModel? info;
  InfoUserResponse();

  factory InfoUserResponse.fromJson(Map<String, dynamic> json) =>
      _$InfoUserResponseFromJson(json);
}
