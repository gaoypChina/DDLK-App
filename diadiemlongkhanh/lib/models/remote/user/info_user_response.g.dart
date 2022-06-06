// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'info_user_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InfoUserResponse _$InfoUserResponseFromJson(Map<String, dynamic> json) =>
    InfoUserResponse()
      ..error = json['error'] as String?
      ..success = json['success'] as bool?
      ..token = json['token'] as String?
      ..avatar = json['avatar'] as String?
      ..info = json['info'] == null
          ? null
          : UserModel.fromJson(json['info'] as Map<String, dynamic>);

Map<String, dynamic> _$InfoUserResponseToJson(InfoUserResponse instance) =>
    <String, dynamic>{
      'error': instance.error,
      'success': instance.success,
      'token': instance.token,
      'avatar': instance.avatar,
      'info': instance.info,
    };
