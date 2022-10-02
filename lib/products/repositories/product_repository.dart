import 'package:dio/dio.dart' hide Headers;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_uber_eats/common/dio/dio.dart';
import 'package:flutter_uber_eats/common/models/cursor_pagination_model.dart';
import 'package:flutter_uber_eats/common/models/pagination_params.dart';
import 'package:flutter_uber_eats/common/repositories/base_pagination_repository.dart';
import 'package:flutter_uber_eats/products/models/product_model.dart';
import 'package:retrofit/http.dart';

import '../../common/constraints/data.dart';

part 'product_repository.g.dart';

final productRepositoryProvider = Provider<ProductRepository>(
  (ref) {
    final dio = ref.watch(dioProvider);

    return ProductRepository(dio, baseUrl: 'http://$ip/product');
  },
);

// http://$ip/product
@RestApi()
abstract class ProductRepository implements IBasePaginationRepository<ProductModel> {
  factory ProductRepository(Dio dio, {String baseUrl}) = _ProductRepository;

  @override
  @GET('/')
  @Headers({'accessToken': 'true'})
  Future<CursorPagination<ProductModel>> paginate({
    @Queries() PaginationParams? paginationParams = const PaginationParams(),
  });
}
