import 'package:diadiemlongkhanh/models/remote/thumnail/thumbnail_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'category_response.g.dart';

@JsonSerializable()
class CategoryModel {
  @JsonKey(name: '_id')
  String? id;
  bool? isHot;
  int? order;
  String? name;
  String? slug;
  ThumbnailModel? thumbnail;
  CategoryModel? category;

  CategoryModel({
    this.id,
    this.name,
  });
  factory CategoryModel.fromJson(Map<String, dynamic> json) =>
      _$CategoryModelFromJson(json);
}
