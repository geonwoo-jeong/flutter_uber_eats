import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_uber_eats/common/models/cursor_pagination_model.dart';

import '../repositories/restaurant_rating_repository.dart';

class RestaurantRatingStateNotifier
    extends StateNotifier<CursorPaginationBase> {
  final RestaurantRatingRepository repository;

  RestaurantRatingStateNotifier({
    required this.repository,
  }) : super(
          CursorPaginationLoading(),
        );
}
