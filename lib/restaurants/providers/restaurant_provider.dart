import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_uber_eats/common/models/cursor_pagination_model.dart';
import 'package:flutter_uber_eats/common/models/pagination_params.dart';
import 'package:flutter_uber_eats/restaurants/models/restaurant_model.dart';

import '../repositories/restaurant_repository.dart';

final restaurantProvider =
    StateNotifierProvider<RestaurantStateNotifier, CursorPaginationBase>((ref) {
  final repository = ref.watch(restaurantRepositoryProvider);

  final notifier = RestaurantStateNotifier(repository: repository);

  return notifier;
});

class RestaurantStateNotifier extends StateNotifier<CursorPaginationBase> {
  final RestaurantRepository repository;

  RestaurantStateNotifier({
    required this.repository,
  }) : super(CursorPaginationLoading()) {
    paginate();
  }

  void paginate({
    int fetchCount = 20,
    bool fetchMore = false,
    bool forceReFetch = false,
  }) async {
    try {
      if (state is CursorPagination && !forceReFetch) {
        final pState = state as CursorPagination;

        if (!pState.meta.hasMore) {
          return;
        }
      }

      final isLoading = state is CursorPaginationLoading;
      final isReFetching = state is CursorPaginationReFetching;
      final isFetchingMore = state is CursorPaginationFetchingMore;

      if (fetchMore && (isLoading || isReFetching || isFetchingMore)) {
        return;
      }

      // Generate PaginationParams
      PaginationParams paginationParams = PaginationParams(
        count: fetchCount,
      );

      // fetchMore
      if (fetchMore) {
        final pState = state as CursorPagination;

        state = CursorPaginationFetchingMore(
          meta: pState.meta,
          data: pState.data,
        );

        paginationParams = paginationParams.copyWith(
          after: pState.data.last.id,
        );

        final resp = await repository.paginate(
          paginationParams: paginationParams,
        );

        if (state is CursorPaginationFetchingMore) {
          final pState = state as CursorPaginationFetchingMore;

          state = resp.copyWith(
            data: [
              ...pState.data,
              ...resp.data,
            ],
          );
        }
      } else {
        if (state is CursorPagination && !forceReFetch) {
          final pState = state as CursorPagination;

          state = CursorPaginationReFetching(
            meta: pState.meta,
            data: pState.data,
          );
        } else {
          state = CursorPaginationLoading();
        }
      }

      final resp = await repository.paginate(
        paginationParams: paginationParams,
      );

      if (state is CursorPaginationFetchingMore) {
        final pState = state as CursorPaginationFetchingMore;

        state = resp.copyWith(
          data: [
            ...pState.data,
            ...resp.data,
          ],
        );
      } else {
        state = resp;
      }
    } catch(e) {
      state = CursorPaginationError(message: 'Fetching fail');
    }
}
