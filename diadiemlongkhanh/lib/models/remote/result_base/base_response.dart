import 'package:json_annotation/json_annotation.dart';

part 'base_response.g.dart';

abstract class BaseResponse {
  ErrorModel? error;
}

@JsonSerializable()
class ErrorModel {
  int? status;
  String? message;

  ErrorModel();
  factory ErrorModel.fromJson(Map<String, dynamic> json) =>
      _$ErrorModelFromJson(json);
}
