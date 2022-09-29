import 'package:flutter/material.dart';
import 'package:flutter_uber_eats/common/layouts/default_layout.dart';
import 'package:flutter_uber_eats/products/components/product_card.dart';

import '../components/restaurant_card.dart';

class RestaurantDetailScreen extends StatelessWidget {
  const RestaurantDetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      title: '불타는 떡볶이',
      child: CustomScrollView(
        slivers: [
          renderTop(),
          renderLabel(),
          renderProducts(),
        ],
      ),
      // child: Column(
      //   children: [
      //     RestaurantCard(
      //       image: Image.asset(name),
      //       name: '불타는 떡볶이',
      //       tags: ['떡볶이', '맛있음', '차즈'],
      //       ratingsCount: 100,
      //       deliveryTime: 30,
      //       deliveryFee: 3600,
      //       ratings: 4.76,
      //       isDetail: true,
      //     ),
      //     Padding(
      //       padding: const EdgeInsets.symmetric(horizontal: 16.0),
      //       child: ProductCard(),
      //     )
      //   ],
      // ),
    );
  }

  SliverToBoxAdapter renderTop() {
    return SliverToBoxAdapter(
      child: RestaurantCard(
        image: Image.asset('hi'),
        name: '불타는 떡볶이',
        tags: ['떡볶이', '맛있음', '차즈'],
        ratingsCount: 100,
        deliveryTime: 30,
        deliveryFee: 3600,
        ratings: 4.76,
        isDetail: true,
      ),
    );
  }

  SliverPadding renderLabel() {
    return SliverPadding(
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

  SliverPadding renderProducts() {
    return SliverPadding(
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            return Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: ProductCard(),
            );
          },
          childCount: 10,
        ),
      ),
    );
  }
}
