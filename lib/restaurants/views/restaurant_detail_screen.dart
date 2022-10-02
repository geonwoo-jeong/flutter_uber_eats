import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_uber_eats/common/layouts/default_layout.dart';
import 'package:flutter_uber_eats/products/components/product_card.dart';
import 'package:flutter_uber_eats/ratings/components/rating_card.dart';
import 'package:flutter_uber_eats/restaurants/models/restaurant_detail_model.dart';
import 'package:flutter_uber_eats/restaurants/models/restaurant_model.dart';
import 'package:flutter_uber_eats/restaurants/providers/restaurant_provider.dart';
import 'package:skeletons/skeletons.dart';

import '../components/restaurant_card.dart';

class RestaurantDetailScreen extends ConsumerStatefulWidget {
  final String id;

  const RestaurantDetailScreen({
    required this.id,
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState<RestaurantDetailScreen> createState() =>
      _RestaurantDetailScreenState();
}

class _RestaurantDetailScreenState
    extends ConsumerState<RestaurantDetailScreen> {
  @override
  void initState() {
    super.initState();

    ref.read(restaurantProvider.notifier).getDetail(id: widget.id);
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(restaurantDetailProvider(widget.id));

    if (state == null) {
      return const DefaultLayout(
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return DefaultLayout(
      title: '불타는 떡볶이',
      child: CustomScrollView(
        slivers: [
          renderTop(model: state),
          if (state is! RestaurantDetailModel) renderLoading(),
          if (state is RestaurantDetailModel) renderLabel(),
          if (state is RestaurantDetailModel)
            renderProducts(products: state.products),
          SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            sliver: SliverToBoxAdapter(
              child: RatingCard(
                rating: 4,
                email: 'jc@codefactory.ai',
                images: [],
                avatarImage:
                    AssetImage('assets/images/logo/code_factory_logo.png'),
                content: 'Taste good!',
              ),
            ),
          )
        ],
      ),
    );
  }

  SliverPadding renderLoading() {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(
        vertical: 16.0,
        horizontal: 16.0,
      ),
      sliver: SliverList(
        delegate: SliverChildListDelegate(
          [
            Padding(
              padding: const EdgeInsets.only(
                bottom: 32.0,
              ),
              child: SkeletonParagraph(
                style: const SkeletonParagraphStyle(
                  lines: 5,
                  padding: EdgeInsets.zero,
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: const [
                    SkeletonAvatar(
                      style: SkeletonAvatarStyle(
                        width: 110,
                        height: 110,
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 16.0),
                Expanded(
                  child: Column(
                    children: [
                      const SkeletonLine(
                        style: SkeletonLineStyle(
                            height: 18.0,
                            width: 80.0,
                            padding: EdgeInsets.zero,
                            alignment: AlignmentDirectional.topStart),
                      ),
                      SkeletonParagraph(
                        style: const SkeletonParagraphStyle(
                          lines: 2,
                          padding: EdgeInsets.only(top: 16.0),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
            const SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: const [
                    SkeletonAvatar(
                      style: SkeletonAvatarStyle(
                        width: 110,
                        height: 110,
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 16.0),
                Expanded(
                  child: Column(
                    children: [
                      const SkeletonLine(
                        style: SkeletonLineStyle(
                            height: 18.0,
                            width: 80.0,
                            padding: EdgeInsets.zero,
                            alignment: AlignmentDirectional.topStart),
                      ),
                      SkeletonParagraph(
                        style: const SkeletonParagraphStyle(
                          lines: 2,
                          padding: EdgeInsets.only(top: 16.0),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  SliverToBoxAdapter renderTop({
    required RestaurantModel model,
  }) {
    return SliverToBoxAdapter(
      child: RestaurantCard.fromModel(
        model: model,
        isDetail: true,
      ),
    );
  }

  SliverPadding renderLabel() {
    return const SliverPadding(
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      sliver: SliverToBoxAdapter(
        child: Text(
          'Menu',
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  SliverPadding renderProducts({
    required List<RestaurantProductModel> products,
  }) {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            final model = products[index];
            return Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: ProductCard.fromModel(model: model),
            );
          },
          childCount: products.length,
        ),
      ),
    );
  }
}
