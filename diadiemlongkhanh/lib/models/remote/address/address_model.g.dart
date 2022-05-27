// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'address_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddressModel _$AddressModelFromJson(Map<String, dynamic> json) => AddressModel()
  ..specific = json['specific'] as String?
  ..geo = json['geo'] == null
      ? null
      : GeoModel.fromJson(json['geo'] as Map<String, dynamic>);

Map<String, dynamic> _$AddressModelToJson(AddressModel instance) =>
    <String, dynamic>{
      'specific': instance.specific,
      'geo': instance.geo,
    };

GeoModel _$GeoModelFromJson(Map<String, dynamic> json) => GeoModel()
  ..long = (json['long'] as num?)?.toDouble()
  ..lat = (json['lat'] as num?)?.toDouble();

Map<String, dynamic> _$GeoModelToJson(GeoModel instance) => <String, dynamic>{
      'long': instance.long,
      'lat': instance.lat,
    };
