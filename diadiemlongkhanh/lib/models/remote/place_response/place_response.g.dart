// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'place_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PlaceModel _$PlaceModelFromJson(Map<String, dynamic> json) => PlaceModel()
  ..distance = (json['distance'] as num?)?.toDouble()
  ..id = json['_id'] as String?
  ..name = json['name'] as String?
  ..slug = json['slug'] as String?
  ..avatar = json['avatar'] == null
      ? null
      : AvatarModel.fromJson(json['avatar'] as Map<String, dynamic>)
  ..address = json['address'] == null
      ? null
      : AddressModel.fromJson(json['address'] as Map<String, dynamic>)
  ..openingStatus = json['openingStatus'] as String?
  ..region = json['region'] == null
      ? null
      : RegionModel.fromJson(json['region'] as Map<String, dynamic>);

Map<String, dynamic> _$PlaceModelToJson(PlaceModel instance) =>
    <String, dynamic>{
      'distance': instance.distance,
      '_id': instance.id,
      'name': instance.name,
      'slug': instance.slug,
      'avatar': instance.avatar,
      'address': instance.address,
      'openingStatus': instance.openingStatus,
      'region': instance.region,
    };

RegionModel _$RegionModelFromJson(Map<String, dynamic> json) =>
    RegionModel()..name = json['name'] as String?;

Map<String, dynamic> _$RegionModelToJson(RegionModel instance) =>
    <String, dynamic>{
      'name': instance.name,
    };
