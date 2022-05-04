import 'package:diadiemlongkhanh/models/remote/place_response/place_response.dart';
import 'package:diadiemlongkhanh/models/remote/slide/slide_response.dart';
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
}
