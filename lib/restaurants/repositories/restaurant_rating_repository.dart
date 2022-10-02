import 'package:dio/dio.dart' hide Headers;
import 'package:flutter_uber_eats/ratings/models/rating_model.dart';
import 'package:retrofit/http.dart';

import '../../common/models/cursor_pagination_model.dart';
import '../../common/models/pagination_params.dart';

part 'restaurant_rating_repository.g.dart';

@RestApi()
abstract class RestaurantRatingRepository {
  factory RestaurantRatingRepository(Dio dio, {String baseUrl}) =
      _RestaurantRatingRepository;

  @GET('/')
  @Headers({'accessToken': 'true'})
  Future<CursorPagination<RatingModel>> paginate({
    @Queries() PaginationParams? paginationParams = const PaginationParams(),
  });
}
