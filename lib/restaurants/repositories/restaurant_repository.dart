import 'package:dio/dio.dart' hide Headers;
import 'package:flutter_uber_eats/restaurants/models/restaurant_detail_model.dart';
import 'package:retrofit/http.dart';

part 'restaurant_repository.g.dart';

@RestApi()
abstract class RestaurantRepository {
  factory RestaurantRepository(Dio dio, {String baseUrl}) =
      _RestaurantRepository;
  //
  // @GET('/')
  // paginate();

  @GET('/{id}')
  @Headers(
    {'accessToken': 'true'},
  )
  Future<RestaurantDetailModel> getRestaurantDetail({
    @Path() required String id,
  });
}