import 'package:flutter/material.dart';
import 'package:flutter_uber_eats/common/layouts/default_layout.dart';
import 'package:flutter_uber_eats/common/restaurants/components/restaurant_card.dart';

class RestaurantDetailScreen extends StatelessWidget {
  const RestaurantDetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      title: '불타는 떡볶이',
      child: Column(
        children: [
          RestaurantCard(
            image: Image.asset(name),
            name: '불타는 떡볶이',
            tags: ['떡볶이', '맛있음', '차즈'],
            ratingsCount: 100,
            deliveryTime: 30,
            deliveryFee: 3600,
            ratings: 4.76,
            isDetail: true,
          )
        ],
      ),
    );
  }
}
