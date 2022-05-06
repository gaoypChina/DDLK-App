// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'result_new_feed_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResultNewFeedModel _$ResultNewFeedModelFromJson(Map<String, dynamic> json) =>
    ResultNewFeedModel()
      ..info = json['info'] == null
          ? null
          : InfoPagingModel.fromJson(json['info'] as Map<String, dynamic>)
      ..result = (json['result'] as List<dynamic>?)
              ?.map((e) => NewFeedModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [];

Map<String, dynamic> _$ResultNewFeedModelToJson(ResultNewFeedModel instance) =>
    <String, dynamic>{
      'info': instance.info,
      'result': instance.result,
    };
