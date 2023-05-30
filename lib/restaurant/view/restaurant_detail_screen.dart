import 'package:codefactory_flutte_project/common/layout/default_layout.dart';
import 'package:codefactory_flutte_project/product/component/product_card.dart';
import 'package:codefactory_flutte_project/restaurant/component/restaurant_card.dart';
import 'package:flutter/material.dart';

class RestaurantDetailScreen extends StatelessWidget {
  const RestaurantDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
        title: "떡뽂이",
        child: CustomScrollView(
          slivers: [
            randerTop(),
            randerLabel(),
            randerProducts(),
          ],
        ));
  }

  SliverToBoxAdapter randerTop() {
    return SliverToBoxAdapter(
      child: RestaurantCard(
        image: Image.asset(
          'asset/img/food/ddeok_bok_gi.jpg',
          fit: BoxFit.cover,
        ),
        name: '엽기 떡볶이',
        tags: const ['떡볶이', '치즈', '매운맛'],
        ratingsCount: 100,
        deliveryTime: 15,
        deliveryFee: 2000,
        ratings: 4.52,
        isDetail: true,
      ),
    );
  }

  SliverPadding randerProducts() {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate(
          childCount: 10,
          (context, index) {
            return const Padding(
              padding: EdgeInsets.only(top: 16.0),
              child: ProductCard(),
            );
          },
        ),
      ),
    );
  }

  SliverPadding randerLabel() {
    return const SliverPadding(
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        sliver: SliverToBoxAdapter(
          child: Text(
            "메뉴",
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.w500,
            ),
          ),
        ));
  }
}
