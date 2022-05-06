import 'package:diadiemlongkhanh/models/remote/place_response/place_response.dart';
import 'package:diadiemlongkhanh/models/remote/thumnail/thumbnail_model.dart';
import 'package:diadiemlongkhanh/models/remote/user/user_response.dart';
import 'package:json_annotation/json_annotation.dart';

part 'new_feed_response.g.dart';

@JsonSerializable()
class NewFeedModel {
  @JsonKey(name: '_id')
  String? id;
  double? rateAvg;
  double? rateView;
  double? rateDrink;
  double? rateService;
  double? ratePrice;
  String? content;
  @JsonKey(defaultValue: false)
  late bool anonymous;
  @JsonKey(defaultValue: false)
  late bool isExplore;
  @JsonKey(defaultValue: false)
  late bool isHide;
  @JsonKey(defaultValue: [])
  late List<ThumbnailModel> images;
  @JsonKey(defaultValue: false)
  late bool deleted;
  PlaceModel? place;
  String? createdAt;
  String? title;
  String? slug;
  String? exploreAt;
  int? commentCount;
  int? likeCount;
  @JsonKey(defaultValue: false)
  late bool canEdit;
  @JsonKey(defaultValue: false)
  late bool isLiked;
  UserModel? author;

  NewFeedModel();
  factory NewFeedModel.fromJson(Map<String, dynamic> json) =>
      _$NewFeedModelFromJson(json);
}


    // "author": {
    //   "_id": "625bf8773d4a6b5f472bc72d",
    //   "role": "admin",
    //   "avatar": "uploads/images/2022/04/21/21beca98-b05d-4676-b0f3-6fae116ce57b-212EE9F6-6F64-496D-BED3-AEE3A3.jpeg",
    //   "name": "Phan Văn Hoài",
    //   "username": "hoaipv",
    //   "savedCount": 0
    // },
