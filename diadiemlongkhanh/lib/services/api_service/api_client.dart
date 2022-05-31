import 'package:diadiemlongkhanh/models/remote/base/auth_response.dart';
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

  @GET('${Apis.voucher}/{id}')
  Future<VoucherModel?> getDetailVoucher(@Path() String id);

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

  @POST(Apis.auth_register_with_phone)
  Future<AuthResponse?> registerWithPhone(@Body() data);

  @POST(Apis.auth_resend_otp)
  Future<AuthResponse?> resendOtp(@Body() data);
  @POST(Apis.auth_register_confirm)
  Future<AuthResponse?> registerConfirm(@Body() data);
  @POST(Apis.auth_login)
  Future<AuthResponse?> loginBasic(@Body() data);
  @POST('${Apis.review}/{id}/like')
  Future<AuthResponse?> likeReview(@Path() String id);
  @DELETE('${Apis.review}/{id}/like')
  Future<AuthResponse?> unLikeReview(@Path() String id);
  @POST('${Apis.comment}')
  Future<CommentModel?> commentReview(@Body() data);
  @POST(Apis.login_with_otp)
  Future<AuthResponse?> loginWithOtp(@Body() data);
  @POST(Apis.login_with_otp_confirm)
  Future<AuthResponse?> loginWithOtpConfirm(@Body() data);
  @POST(Apis.recover)
  Future<AuthResponse?> forgotPassword(@Body() data);
  @POST(Apis.recover_confirm)
  Future<AuthResponse?> resetPassword(@Body() data);
  @POST('${Apis.comment}/{id}/like')
  Future<AuthResponse?> likeCommentReview(@Path() String id);
  @DELETE('${Apis.comment}/{id}/like')
  Future<AuthResponse?> unlikeCommentReview(@Path() String id);
  @GET('${Apis.places}/{ids}')
  Future<List<PlaceModel>?> getPlacesSeen(@Path() String ids);
  @GET(Apis.suggest_search)
  Future<List<PlaceModel>?> getPlacesSuggest(
    @Query('key') String key, {
    @Query('limit') int limit = 5,
  });
  @POST('${Apis.place}/{id}/save')
  Future<AuthResponse?> savePlace(
    @Path() String id,
  );
}
