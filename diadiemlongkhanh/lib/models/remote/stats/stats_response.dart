import 'package:json_annotation/json_annotation.dart';

part 'stats_response.g.dart';

@JsonSerializable()
class StatsModel {
  int? countReviews;
  int? countComments;
  int? countFollowers;
  int? countLikes;

  StatsModel();
  factory StatsModel.fromJson(Map<String, dynamic> json) =>
      _$StatsModelFromJson(json);
}
