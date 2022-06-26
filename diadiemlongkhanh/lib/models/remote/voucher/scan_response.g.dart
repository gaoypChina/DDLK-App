// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'scan_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ScanResponse _$ScanResponseFromJson(Map<String, dynamic> json) => ScanResponse()
  ..error = json['error'] == null
      ? null
      : ErrorModel.fromJson(json['error'] as Map<String, dynamic>);

Map<String, dynamic> _$ScanResponseToJson(ScanResponse instance) =>
    <String, dynamic>{
      'error': instance.error,
    };
