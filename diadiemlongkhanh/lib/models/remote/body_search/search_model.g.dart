// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SearchModel _$SearchModelFromJson(Map<String, dynamic> json) => SearchModel(
      page: json['page'] as int?,
      pageSize: json['pageSize'] as int?,
    )..keyword = json['keyword'] as String?;

Map<String, dynamic> _$SearchModelToJson(SearchModel instance) =>
    <String, dynamic>{
      'keyword': instance.keyword,
      'page': instance.page,
      'pageSize': instance.pageSize,
    };
