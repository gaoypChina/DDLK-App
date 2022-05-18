import 'package:diadiemlongkhanh/models/remote/user/user_response.dart';
import 'package:json_annotation/json_annotation.dart';

part 'comment_response.g.dart';

@JsonSerializable()
class CommentModel {
  @JsonKey(name: '_id')
  String? id;
  @JsonKey(defaultValue: false)
  late bool isHide;
  @JsonKey(defaultValue: false)
  late bool deleted;

  String? content;

  String? review;
  UserModel? author;
  String? createdAt;
  @JsonKey(defaultValue: false)
  late bool canEdit;
  int? likeCount;
  @JsonKey(defaultValue: false)
  late bool isLiked;

  CommentModel();
  factory CommentModel.fromJson(Map<String, dynamic> json) =>
      _$CommentModelFromJson(json);
}
