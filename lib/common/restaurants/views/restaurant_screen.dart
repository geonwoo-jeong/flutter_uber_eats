import 'package:flutter/material.dart';
import 'package:flutter_uber_eats/common/restaurants/components/restaurant_card.dart';

class RestaurantScreen extends StatelessWidget {
  const RestaurantScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: RestaurantCard(
        image: Image.asset(
            'assets/images/foods/ddeok_bok_gi.jpeg',
            fit: BoxFit.contain,
        ),
              name: '불타는 떡볶이',
              tags: ['덕볶이', '치즈','매운맛'],
              ratingCount: 100,
              deliveryTime: 15,
              deliveryFee: 2000,
              rating: 4.52,
      ),
          )),
    );
  }
}
