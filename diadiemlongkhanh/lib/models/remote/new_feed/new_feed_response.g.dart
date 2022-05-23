// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'new_feed_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NewFeedModel _$NewFeedModelFromJson(Map<String, dynamic> json) => NewFeedModel()
  ..id = json['_id'] as String?
  ..rateAvg = (json['rateAvg'] as num?)?.toDouble()
  ..rateView = (json['rateView'] as num?)?.toDouble()
  ..rateDrink = (json['rateDrink'] as num?)?.toDouble()
  ..rateService = (json['rateService'] as num?)?.toDouble()
  ..ratePrice = (json['ratePrice'] as num?)?.toDouble()
  ..content = json['content'] as String?
  ..anonymous = json['anonymous'] as bool? ?? false
  ..isExplore = json['isExplore'] as bool? ?? false
  ..isHide = json['isHide'] as bool? ?? false
  ..images = (json['images'] as List<dynamic>?)
          ?.map((e) => ThumbnailModel.fromJson(e as Map<String, dynamic>))
          .toList() ??
      []
  ..deleted = json['deleted'] as bool? ?? false
  ..place = json['place'] == null
      ? null
      : PlaceModel.fromJson(json['place'] as Map<String, dynamic>)
  ..createdAt = json['createdAt'] as String?
  ..title = json['title'] as String?
  ..slug = json['slug'] as String?
  ..exploreAt = json['exploreAt'] as String?
  ..commentCount = json['commentCount'] as int? ?? 0
  ..likeCount = json['likeCount'] as int? ?? 0
  ..canEdit = json['canEdit'] as bool? ?? false
  ..isLiked = json['isLiked'] as bool? ?? false
  ..author = json['author'] == null
      ? null
      : UserModel.fromJson(json['author'] as Map<String, dynamic>);

Map<String, dynamic> _$NewFeedModelToJson(NewFeedModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'rateAvg': instance.rateAvg,
      'rateView': instance.rateView,
      'rateDrink': instance.rateDrink,
      'rateService': instance.rateService,
      'ratePrice': instance.ratePrice,
      'content': instance.content,
      'anonymous': instance.anonymous,
      'isExplore': instance.isExplore,
      'isHide': instance.isHide,
      'images': instance.images,
      'deleted': instance.deleted,
      'place': instance.place,
      'createdAt': instance.createdAt,
      'title': instance.title,
      'slug': instance.slug,
      'exploreAt': instance.exploreAt,
      'commentCount': instance.commentCount,
      'likeCount': instance.likeCount,
      'canEdit': instance.canEdit,
      'isLiked': instance.isLiked,
      'author': instance.author,
    };
