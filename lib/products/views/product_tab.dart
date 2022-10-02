import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_uber_eats/products/providers/product_provider.dart';

class ProductTab extends ConsumerStatefulWidget {
  const ProductTab({Key? key}) : super(key: key);

  @override
  ConsumerState<ProductTab> createState() => _ProductTabState();
}

class _ProductTabState extends ConsumerState<ProductTab> {
  @override
  Widget build(BuildContext context) {
    final state = ref.watch(productProvider);
    return Center(
      child: Text('food'),
    );
  }
}
