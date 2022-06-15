// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel()
  ..id = json['_id'] as String?
  ..role = json['role'] as String?
  ..avatar = json['avatar'] as String?
  ..name = json['name'] as String?
  ..username = json['username'] as String?
  ..savedCount = json['savedCount'] as int?
  ..gender = json['gender'] as bool?
  ..email = json['email'] as String?
  ..social = json['social'] == null
      ? null
      : SocialModel.fromJson(json['social'] as Map<String, dynamic>)
  ..phone = json['phone'] as String?
  ..birth = json['birth'] as String?
  ..isFollowed = json['isFollowed'] as bool? ?? false
  ..createdAt = json['createdAt'] == null
      ? null
      : DateTime.parse(json['createdAt'] as String);

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      '_id': instance.id,
      'role': instance.role,
      'avatar': instance.avatar,
      'name': instance.name,
      'username': instance.username,
      'savedCount': instance.savedCount,
      'gender': instance.gender,
      'email': instance.email,
      'social': instance.social,
      'phone': instance.phone,
      'birth': instance.birth,
      'isFollowed': instance.isFollowed,
      'createdAt': instance.createdAt?.toIso8601String(),
    };
