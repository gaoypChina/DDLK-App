// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResultNotificationResponse _$ResultNotificationResponseFromJson(
        Map<String, dynamic> json) =>
    ResultNotificationResponse()
      ..info = json['info'] == null
          ? null
          : InfoPagingModel.fromJson(json['info'] as Map<String, dynamic>)
      ..result = (json['result'] as List<dynamic>?)
          ?.map((e) => NotificationModel.fromJson(e as Map<String, dynamic>))
          .toList();

Map<String, dynamic> _$ResultNotificationResponseToJson(
        ResultNotificationResponse instance) =>
    <String, dynamic>{
      'info': instance.info,
      'result': instance.result,
    };

NotificationModel _$NotificationModelFromJson(Map<String, dynamic> json) =>
    NotificationModel()
      ..error = json['error'] == null
          ? null
          : ErrorModel.fromJson(json['error'] as Map<String, dynamic>)
      ..id = json['_id'] as String?
      ..receiverType = json['receiverType'] as String?
      ..sendTime = json['sendTime'] as String?
      ..docModel = json['docModel'] as String?
      ..title = json['title'] as String?
      ..body = json['body'] as String?
      ..doc = json['doc'] as String?
      ..thumbnail = json['thumbnail'] == null
          ? null
          : ThumbnailModel.fromJson(json['thumbnail'] as Map<String, dynamic>);

Map<String, dynamic> _$NotificationModelToJson(NotificationModel instance) =>
    <String, dynamic>{
      'error': instance.error,
      '_id': instance.id,
      'receiverType': instance.receiverType,
      'sendTime': instance.sendTime,
      'docModel': instance.docModel,
      'title': instance.title,
      'body': instance.body,
      'doc': instance.doc,
      'thumbnail': instance.thumbnail,
    };
