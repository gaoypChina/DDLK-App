import 'package:diadiemlongkhanh/models/remote/info_paging/info_paging_response.dart';
import 'package:diadiemlongkhanh/models/remote/result_base/base_response.dart';
import 'package:diadiemlongkhanh/models/remote/result_base/result_base_response.dart';
import 'package:diadiemlongkhanh/models/remote/thumnail/thumbnail_model.dart';

import 'package:json_annotation/json_annotation.dart';
part 'notification_response.g.dart';

@JsonSerializable()
class ResultNotificationResponse extends ResultBaseResponse {
  List<NotificationModel>? result;
  ErrorModel? error;

  ResultNotificationResponse();
  factory ResultNotificationResponse.fromJson(Map<String, dynamic> json) =>
      _$ResultNotificationResponseFromJson(json);
}

@JsonSerializable()
class NotificationModel extends BaseResponse {
  @JsonKey(name: '_id')
  String? id;
  String? receiverType;
  String? sendTime;
  String? docModel;
  String? title;
  String? body;
  String? doc;
  ThumbnailModel? thumbnail;
  NotificationModel();
  factory NotificationModel.fromJson(Map<String, dynamic> json) =>
      _$NotificationModelFromJson(json);
}
