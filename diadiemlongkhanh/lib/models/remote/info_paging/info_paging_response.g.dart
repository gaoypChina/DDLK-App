// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'info_paging_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InfoPagingModel _$InfoPagingModelFromJson(Map<String, dynamic> json) =>
    InfoPagingModel()
      ..current = json['current'] as int? ?? 0
      ..pageSize = json['pageSize'] as int? ?? 0
      ..total = json['total'] as int? ?? 0;

Map<String, dynamic> _$InfoPagingModelToJson(InfoPagingModel instance) =>
    <String, dynamic>{
      'current': instance.current,
      'pageSize': instance.pageSize,
      'total': instance.total,
    };
