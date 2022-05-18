import 'package:diadiemlongkhanh/models/remote/category/category_response.dart';
import 'package:diadiemlongkhanh/models/remote/comment/comment_response.dart';
import 'package:diadiemlongkhanh/models/remote/new_feed/new_feed_response.dart';
import 'package:diadiemlongkhanh/models/remote/new_feed/result_new_feed_response.dart';
import 'package:diadiemlongkhanh/models/remote/place_response/place_response.dart';
import 'package:diadiemlongkhanh/models/remote/place_response/result_place_response.dart';
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

  @GET(Apis.places_new)
  Future<List<PlaceModel>?> getPlacesNew({
    @Query('subcategory') String subCategory = '',
    @Query('limit') int limit = 5,
  });

  @GET(Apis.explores_new)
  Future<List<NewFeedModel>?> getExploresNew({
    @Query('limit') int limit = 5,
  });

  @GET(Apis.explores)
  Future<ResultNewFeedModel?> getExplores({
    @Query('page') int page = 1,
    @Query('pageSize') int pageSize = 10,
  });

  @GET('${Apis.place}/{id}/reviews')
  Future<ResultNewFeedModel?> getReviewsOfPlace(
    @Path() String id, {
    @Query('page') int page = 1,
    @Query('pageSize') int pageSize = 10,
  });

  @GET(Apis.categories)
  Future<List<CategoryModel>?> getCategories();

  @GET('${Apis.place}/{id}')
  Future<PlaceModel?> getDetailPlace(@Path() String id);

  @POST('${Apis.place_search}')
  Future<ResultPlaceModel?> searchPlaces(@Body() data);

  @GET('${Apis.review}/{id}/comments')
  Future<List<CommentModel>?> getCommentyOfReview(@Path() String id);
}
