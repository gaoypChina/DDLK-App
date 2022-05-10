// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'result_place_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResultPlaceModel _$ResultPlaceModelFromJson(Map<String, dynamic> json) =>
    ResultPlaceModel()
      ..info = json['info'] == null
          ? null
          : InfoPagingModel.fromJson(json['info'] as Map<String, dynamic>)
      ..result = (json['result'] as List<dynamic>?)
              ?.map((e) => PlaceModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [];

Map<String, dynamic> _$ResultPlaceModelToJson(ResultPlaceModel instance) =>
    <String, dynamic>{
      'info': instance.info,
      'result': instance.result,
    };
