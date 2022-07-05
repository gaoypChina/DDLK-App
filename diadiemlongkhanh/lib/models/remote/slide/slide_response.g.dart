// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'slide_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SlideModel _$SlideModelFromJson(Map<String, dynamic> json) => SlideModel()
  ..id = json['_id'] as String?
  ..order = json['order'] as int?
  ..name = json['name'] as String?
  ..photo = json['photo'] == null
      ? null
      : PhotoModel.fromJson(json['photo'] as Map<String, dynamic>)
  ..docModel = json['docModel'] as String?
  ..doc = json['doc'] as String?;

Map<String, dynamic> _$SlideModelToJson(SlideModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'order': instance.order,
      'name': instance.name,
      'photo': instance.photo,
      'docModel': instance.docModel,
      'doc': instance.doc,
    };

PhotoModel _$PhotoModelFromJson(Map<String, dynamic> json) => PhotoModel()
  ..id = json['_id'] as String?
  ..path = json['path'] as String?;

Map<String, dynamic> _$PhotoModelToJson(PhotoModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'path': instance.path,
    };
