import 'package:diadiemlongkhanh/models/remote/address/address_model.dart';
import 'package:diadiemlongkhanh/models/remote/avatar/avatar_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'place_response.g.dart';

@JsonSerializable()
class PlaceModel {
  double? distance;
  @JsonKey(name: '_id')
  String? id;
  String? name;
  String? slug;
  AvatarModel? avatar;
  AddressModel? address;
  String? openingStatus;
  RegionModel? region;
  PlaceModel();
  factory PlaceModel.fromJson(Map<String, dynamic> json) =>
      _$PlaceModelFromJson(json);
}

@JsonSerializable()
class RegionModel {
  String? name;
  RegionModel();
  factory RegionModel.fromJson(Map<String, dynamic> json) =>
      _$RegionModelFromJson(json);
}
