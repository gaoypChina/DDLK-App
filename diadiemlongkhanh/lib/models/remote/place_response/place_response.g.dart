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
      : RegionModel.fromJson(json['region'] as Map<String, dynamic>)
  ..avgRate = (json['avgRate'] as num?)?.toDouble()
  ..verified = json['verified'] as bool? ?? false
  ..isClosed = json['isClosed'] as bool? ?? false
  ..isHot = json['isHot'] as bool? ?? false
  ..subCategories = (json['subCategories'] as List<dynamic>?)
          ?.map((e) => CategoryModel.fromJson(e as Map<String, dynamic>))
          .toList() ??
      []
  ..benefits = (json['benefits'] as List<dynamic>?)
          ?.map((e) => BenefitModel.fromJson(e as Map<String, dynamic>))
          .toList() ??
      []
  ..images = (json['images'] as List<dynamic>?)
          ?.map((e) => ThumbnailModel.fromJson(e as Map<String, dynamic>))
          .toList() ??
      []
  ..menu = (json['menu'] as List<dynamic>?)
          ?.map((e) => ThumbnailModel.fromJson(e as Map<String, dynamic>))
          .toList() ??
      []
  ..view = json['view'] as int? ?? 0
  ..deleted = json['deleted'] as bool? ?? false
  ..isSaved = json['isSaved'] as bool? ?? false
  ..category = json['category'] == null
      ? null
      : CategoryModel.fromJson(json['category'] as Map<String, dynamic>)
  ..intro = json['intro'] as String?
  ..metaKeywords = json['metaKeywords'] as String?
  ..facebook = json['facebook'] == null
      ? null
      : SocialModel.fromJson(json['facebook'] as Map<String, dynamic>)
  ..email = json['email'] as String?
  ..phone = json['phone'] as String?
  ..video = json['video'] as String?
  ..imageCount = json['imageCount'] as int?
  ..reviewCount = json['reviewCount'] as int?
  ..openingType = json['openingType'] as String?
  ..openingTime = json['openingTime'] == null
      ? null
      : OpeningTimeModel.fromJson(json['openingTime'] as Map<String, dynamic>)
  ..rate = json['rate'] == null
      ? null
      : RateModel.fromJson(json['rate'] as Map<String, dynamic>)
  ..price = json['price'] == null
      ? null
      : PriceModel.fromJson(json['price'] as Map<String, dynamic>)
  ..social = json['social'] == null
      ? null
      : SocialModel.fromJson(json['social'] as Map<String, dynamic>)
  ..voucherCount = json['voucherCount'] as int?;

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
      'avgRate': instance.avgRate,
      'verified': instance.verified,
      'isClosed': instance.isClosed,
      'isHot': instance.isHot,
      'subCategories': instance.subCategories,
      'benefits': instance.benefits,
      'images': instance.images,
      'menu': instance.menu,
      'view': instance.view,
      'deleted': instance.deleted,
      'isSaved': instance.isSaved,
      'category': instance.category,
      'intro': instance.intro,
      'metaKeywords': instance.metaKeywords,
      'facebook': instance.facebook,
      'email': instance.email,
      'phone': instance.phone,
      'video': instance.video,
      'imageCount': instance.imageCount,
      'reviewCount': instance.reviewCount,
      'openingType': instance.openingType,
      'openingTime': instance.openingTime,
      'rate': instance.rate,
      'price': instance.price,
      'social': instance.social,
      'voucherCount': instance.voucherCount,
    };

RegionModel _$RegionModelFromJson(Map<String, dynamic> json) =>
    RegionModel()..name = json['name'] as String?;

Map<String, dynamic> _$RegionModelToJson(RegionModel instance) =>
    <String, dynamic>{
      'name': instance.name,
    };

PriceModel _$PriceModelFromJson(Map<String, dynamic> json) => PriceModel()
  ..min = json['min'] as int?
  ..max = json['max'] as int?;

Map<String, dynamic> _$PriceModelToJson(PriceModel instance) =>
    <String, dynamic>{
      'min': instance.min,
      'max': instance.max,
    };

OpeningTimeModel _$OpeningTimeModelFromJson(Map<String, dynamic> json) =>
    OpeningTimeModel()
      ..mon = json['0'] as String?
      ..tue = json['1'] as String?
      ..wed = json['2'] as String?
      ..thu = json['3'] as String?
      ..fri = json['4'] as String?
      ..sat = json['5'] as String?
      ..sun = json['6'] as String?;

Map<String, dynamic> _$OpeningTimeModelToJson(OpeningTimeModel instance) =>
    <String, dynamic>{
      '0': instance.mon,
      '1': instance.tue,
      '2': instance.wed,
      '3': instance.thu,
      '4': instance.fri,
      '5': instance.sat,
      '6': instance.sun,
    };

RateModel _$RateModelFromJson(Map<String, dynamic> json) => RateModel()
  ..summary = (json['summary'] as num?)?.toDouble()
  ..position = (json['position'] as num?)?.toDouble()
  ..view = (json['view'] as num?)?.toDouble()
  ..drink = (json['drink'] as num?)?.toDouble()
  ..service = (json['service'] as num?)?.toDouble()
  ..price = (json['price'] as num?)?.toDouble();

Map<String, dynamic> _$RateModelToJson(RateModel instance) => <String, dynamic>{
      'summary': instance.summary,
      'position': instance.position,
      'view': instance.view,
      'drink': instance.drink,
      'service': instance.service,
      'price': instance.price,
    };

SocialModel _$SocialModelFromJson(Map<String, dynamic> json) => SocialModel()
  ..facebook = json['facebook'] as String?
  ..instagram = json['instagram'] as String?;

Map<String, dynamic> _$SocialModelToJson(SocialModel instance) =>
    <String, dynamic>{
      'facebook': instance.facebook,
      'instagram': instance.instagram,
    };
