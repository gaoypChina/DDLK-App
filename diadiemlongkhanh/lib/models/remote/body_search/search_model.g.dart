// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SearchModel _$SearchModelFromJson(Map<String, dynamic> json) => SearchModel(
      page: json['page'] as int?,
      pageSize: json['pageSize'] as int?,
      opening: json['opening'] as bool? ?? true,
      nearby: json['nearby'] as bool? ?? false,
      price: json['price'] as String?,
    )..keyword = json['keyword'] as String?;

Map<String, dynamic> _$SearchModelToJson(SearchModel instance) =>
    <String, dynamic>{
      'keyword': instance.keyword,
      'page': instance.page,
      'pageSize': instance.pageSize,
      'opening': instance.opening,
      'nearby': instance.nearby,
      'price': instance.price,
    };
