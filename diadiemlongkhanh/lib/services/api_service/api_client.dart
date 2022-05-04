import 'package:diadiemlongkhanh/models/remote/category/category_response.dart';
import 'package:diadiemlongkhanh/models/remote/place_response/place_response.dart';
import 'package:diadiemlongkhanh/models/remote/slide/slide_response.dart';
import 'package:diadiemlongkhanh/models/remote/voucher/voucher_response.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import 'apis.dart';

part 'api_client.g.dart';

@RestApi(baseUrl: '')
abstract class ApiClient {
  factory ApiClient(Dio dio) = _ApiClient;

  @GET(Apis.slides)
  Future<List<SlideModel>?> getSlides();

  @GET(Apis.places_near)
  Future<List<PlaceModel>?> getPlacesNear(
    @Query('lat') double lat,
    @Query('long') double long,
    @Query('limit') int limit,
  );
  @GET(Apis.places_hot)
  Future<List<PlaceModel>?> getPlacesHot({
    @Query('limit') int limit = 5,
  });
  @GET(Apis.vouchers)
  Future<List<VoucherModel>?> getVouchers({
    @Query('limit') int limit = 5,
  });

  @GET(Apis.sub_categories)
  Future<List<CategoryModel>?> getSubCategories();
}
