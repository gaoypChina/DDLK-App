// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stats_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StatsModel _$StatsModelFromJson(Map<String, dynamic> json) => StatsModel()
  ..countReviews = json['countReviews'] as int?
  ..countComments = json['countComments'] as int?
  ..countFollowers = json['countFollowers'] as int?
  ..countLikes = json['countLikes'] as int?;

Map<String, dynamic> _$StatsModelToJson(StatsModel instance) =>
    <String, dynamic>{
      'countReviews': instance.countReviews,
      'countComments': instance.countComments,
      'countFollowers': instance.countFollowers,
      'countLikes': instance.countLikes,
    };
