import 'package:flutter/material.dart';
import 'package:flutter_uber_eats/common/components/pagination_list_view.dart';
import 'package:flutter_uber_eats/restaurants/providers/restaurant_provider.dart';
import 'package:flutter_uber_eats/restaurants/views/restaurant_detail_screen.dart';
import 'package:go_router/go_router.dart';

import '../components/restaurant_card.dart';

class RestaurantScreen extends StatelessWidget {
  const RestaurantScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PaginationListView(
      provider: restaurantProvider,
      itemBuilder: <RestaurantModel>(_, index, model) {
        return GestureDetector(
          onTap: () {
            context.goNamed(RestaurantDetailScreen.routeName, params: {
              'rid': model.id,
            });
          },
          child: RestaurantCard.fromModel(model: model),
        );
      },
    );
  }
}
