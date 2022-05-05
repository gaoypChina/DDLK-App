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
  ..savedCount = json['savedCount'] as int?;

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      '_id': instance.id,
      'role': instance.role,
      'avatar': instance.avatar,
      'name': instance.name,
      'username': instance.username,
      'savedCount': instance.savedCount,
    };
