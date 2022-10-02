import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_uber_eats/common/components/pagination_list_view.dart';
import 'package:flutter_uber_eats/products/components/product_card.dart';
import 'package:flutter_uber_eats/products/models/product_model.dart';
import 'package:flutter_uber_eats/products/providers/product_provider.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PaginationListView<ProductModel>(
      provider: productProvider,
      itemBuilder: <ProductModel>(_, index, model) {
        return ProductCard.fromProductModel(model: model);
      },
    );
  }
}
