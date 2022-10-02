import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_uber_eats/common/models/cursor_pagination_model.dart';
import 'package:flutter_uber_eats/common/providers/pagination_provider.dart';
import 'package:flutter_uber_eats/products/models/product_model.dart';
import 'package:flutter_uber_eats/products/repositories/product_repository.dart';

final productProvider = StateNotifierProvider<ProductStateNotifier, CursorPaginationBase>((ref){
  final repo = ref.watch(productRepositoryProvider);

  return ProductStateNotifier(repository: repo);
});

class ProductStateNotifier
    extends PaginationProvider<ProductModel, ProductRepository> {
  ProductStateNotifier({
    required super.repository,
  });
}
