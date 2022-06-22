// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'voucher_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VoucherModel _$VoucherModelFromJson(Map<String, dynamic> json) => VoucherModel()
  ..error = json['error'] == null
      ? null
      : ErrorModel.fromJson(json['error'] as Map<String, dynamic>)
  ..id = json['_id'] as String?
  ..count = json['count'] as int?
  ..code = json['code'] as String?
  ..title = json['title'] as String?
  ..content = json['content'] as String?
  ..startDate = json['startDate'] as String?
  ..endDate = json['endDate'] as String?
  ..place = json['place'] == null
      ? null
      : PlaceModel.fromJson(json['place'] as Map<String, dynamic>)
  ..usedCount = json['usedCount'] as int?
  ..thumbnail = json['thumbnail'] == null
      ? null
      : ThumbnailModel.fromJson(json['thumbnail'] as Map<String, dynamic>);

Map<String, dynamic> _$VoucherModelToJson(VoucherModel instance) =>
    <String, dynamic>{
      'error': instance.error,
      '_id': instance.id,
      'count': instance.count,
      'code': instance.code,
      'title': instance.title,
      'content': instance.content,
      'startDate': instance.startDate,
      'endDate': instance.endDate,
      'place': instance.place,
      'usedCount': instance.usedCount,
      'thumbnail': instance.thumbnail,
    };
