import 'package:diadiemlongkhanh/models/remote/result_base/base_response.dart';
import 'package:json_annotation/json_annotation.dart';

part 'scan_response.g.dart';

@JsonSerializable()
class ScanResponse extends BaseResponse {
  ScanResponse();
  factory ScanResponse.fromJson(Map<String, dynamic> json) =>
      _$ScanResponseFromJson(json);
}
