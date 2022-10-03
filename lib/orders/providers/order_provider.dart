import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_uber_eats/orders/models/order_model.dart';
import 'package:flutter_uber_eats/orders/models/post_order_body.dart';
import 'package:flutter_uber_eats/users/providers/basket_provider.dart';
import 'package:uuid/uuid.dart';

import '../repositores/order_repository.dart';

final orderProvider =
    StateNotifierProvider<OrderStateNotifier, List<OrderModel>>((ref) {
  final repo = ref.watch(orderRepositoryProvider);

  return OrderStateNotifier(
    ref: ref,
    repository: repo,
  );
});

class OrderStateNotifier extends StateNotifier<List<OrderModel>> {
  final Ref ref;
  final OrderRepository repository;

  OrderStateNotifier({
    required this.ref,
    required this.repository,
  }) : super([]);

  Future<bool> postOrder() async {
    try {
      const uuid = Uuid();

      final id = uuid.v4();

      final state = ref.read(basketProvider);

      final resp = await repository.postOrder(
        body: PostOrderBody(
          id: id,
          products: state
              .map(
                (e) => PostOrderBodyProduct(
                  productId: e.product.id,
                  count: e.count,
                ),
              )
              .toList(),
          totalPrice: state.fold<int>(
            0,
            (p, n) => p + (n.count * n.product.price),
          ),
          createdAt: DateTime.now().toString(),
        ),
      );

      return true;
    } catch (e) {
      return false;
    }
  }
}
