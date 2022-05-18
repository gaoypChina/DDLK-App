// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comment_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CommentModel _$CommentModelFromJson(Map<String, dynamic> json) => CommentModel()
  ..id = json['_id'] as String?
  ..isHide = json['isHide'] as bool? ?? false
  ..deleted = json['deleted'] as bool? ?? false
  ..content = json['content'] as String?
  ..review = json['review'] as String?
  ..author = json['author'] == null
      ? null
      : UserModel.fromJson(json['author'] as Map<String, dynamic>)
  ..createdAt = json['createdAt'] as String?
  ..canEdit = json['canEdit'] as bool? ?? false
  ..likeCount = json['likeCount'] as int?
  ..isLiked = json['isLiked'] as bool? ?? false;

Map<String, dynamic> _$CommentModelToJson(CommentModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'isHide': instance.isHide,
      'deleted': instance.deleted,
      'content': instance.content,
      'review': instance.review,
      'author': instance.author,
      'createdAt': instance.createdAt,
      'canEdit': instance.canEdit,
      'likeCount': instance.likeCount,
      'isLiked': instance.isLiked,
    };
