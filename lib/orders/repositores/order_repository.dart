import 'package:dio/dio.dart' hide Headers;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_uber_eats/common/dio/dio.dart';
import 'package:flutter_uber_eats/common/models/pagination_params.dart';
import 'package:flutter_uber_eats/common/repositories/base_pagination_repository.dart';
import 'package:flutter_uber_eats/orders/models/post_order_body.dart';
import 'package:retrofit/http.dart';

import '../../common/constraints/data.dart';
import '../../common/models/cursor_pagination_model.dart';
import '../models/order_model.dart';

part 'order_repository.g.dart';

final orderRepositoryProvider = Provider<OrderRepository>((ref) {
  final dio = ref.watch(dioProvider);

  return OrderRepository(dio, baseUrl: 'http://$ip/order');
});

// http://$ip/order
@RestApi()
abstract class OrderRepository implements IBasePaginationRepository<OrderModel> {
  factory OrderRepository(Dio dio, {String baseUrl}) = _OrderRepository;

  @override
  @GET('/')
  @Headers({
    'accessToken': 'true',
  })
  Future<CursorPagination<OrderModel>> paginate({
    @Queries() PaginationParams? paginationParams = const PaginationParams(),
  });

  @POST('/')
  @Headers({
    'accessToken': 'true',
  })
  Future<OrderModel> postOrder({
    @Body() required PostOrderBody body,
  });
}
