import 'package:diadiemlongkhanh/models/remote/address/address_model.dart';
import 'package:diadiemlongkhanh/models/remote/avatar/avatar_model.dart';
import 'package:diadiemlongkhanh/models/remote/benefit/benefit_response.dart';
import 'package:diadiemlongkhanh/models/remote/category/category_response.dart';
import 'package:diadiemlongkhanh/models/remote/social/social_model.dart';
import 'package:diadiemlongkhanh/models/remote/thumnail/thumbnail_model.dart';
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
  double? avgRate;
  @JsonKey(defaultValue: false)
  late bool verified;
  @JsonKey(defaultValue: false)
  late bool isClosed;
  @JsonKey(defaultValue: false)
  late bool isHot;
  @JsonKey(defaultValue: [])
  late List<CategoryModel> subCategories;
  @JsonKey(defaultValue: [])
  late List<BenefitModel> benefits;
  @JsonKey(defaultValue: [])
  late List<ThumbnailModel> images;
  @JsonKey(defaultValue: [])
  late List<ThumbnailModel> menu;
  @JsonKey(defaultValue: 0)
  late int view;
  @JsonKey(defaultValue: false)
  late bool deleted;
  CategoryModel? category;
  String? intro;
  String? metaKeywords;
  SocialModel? facebook;
  String? email;
  String? phone;
  String? video;
  int? imageCount;
  int? reviewCount;
  String? openingType;
  OpeningTimeModel? openingTime;
  RateModel? rate;
  PriceModel? price;
  SocialModel? social;

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

@JsonSerializable()
class PriceModel {
  int? min;
  int? max;
  PriceModel();
  factory PriceModel.fromJson(Map<String, dynamic> json) =>
      _$PriceModelFromJson(json);
}

@JsonSerializable()
class OpeningTimeModel {
  @JsonKey(name: '0')
  String? mon;
  @JsonKey(name: '1')
  String? tue;
  @JsonKey(name: '2')
  String? wed;
  @JsonKey(name: '3')
  String? thu;
  @JsonKey(name: '4')
  String? fri;
  @JsonKey(name: '5')
  String? sat;
  @JsonKey(name: '6')
  String? sun;

  OpeningTimeModel();
  factory OpeningTimeModel.fromJson(Map<String, dynamic> json) =>
      _$OpeningTimeModelFromJson(json);
}

@JsonSerializable()
class RateModel {
  double? summary;
  double? position;
  double? view;
  double? drink;
  double? service;
  double? price;

  RateModel();
  factory RateModel.fromJson(Map<String, dynamic> json) =>
      _$RateModelFromJson(json);
}

@JsonSerializable()
class SocialModel {
  String? facebook;
  String? instagram;
  SocialModel();
  factory SocialModel.fromJson(Map<String, dynamic> json) =>
      _$SocialModelFromJson(json);
}
