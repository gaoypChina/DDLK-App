import 'package:json_annotation/json_annotation.dart';

part 'benefit_response.g.dart';

@JsonSerializable()
class BenefitModel {
  @JsonKey(name: '_id')
  String? id;
  String? name;
  String? icon;
  String? code;

  BenefitModel();
  factory BenefitModel.fromJson(Map<String, dynamic> json) =>
      _$BenefitModelFromJson(json);
}
