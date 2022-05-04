// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CategoryModel _$CategoryModelFromJson(Map<String, dynamic> json) =>
    CategoryModel()
      ..id = json['_id'] as String?
      ..isHot = json['isHot'] as bool?
      ..order = json['order'] as int?
      ..name = json['name'] as String?
      ..slug = json['slug'] as String?
      ..thumbnail = json['thumbnail'] == null
          ? null
          : ThumbnailModel.fromJson(json['thumbnail'] as Map<String, dynamic>)
      ..category = json['category'] == null
          ? null
          : CategoryModel.fromJson(json['category'] as Map<String, dynamic>);

Map<String, dynamic> _$CategoryModelToJson(CategoryModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'isHot': instance.isHot,
      'order': instance.order,
      'name': instance.name,
      'slug': instance.slug,
      'thumbnail': instance.thumbnail,
      'category': instance.category,
    };
