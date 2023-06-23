import 'package:codefactory_flutte_project/common/layout/default_layout.dart';
import 'package:codefactory_flutte_project/product/component/product_card.dart';
import 'package:codefactory_flutte_project/restaurant/component/restaurant_card.dart';
import 'package:codefactory_flutte_project/restaurant/model/restaurant_detail_model.dart';
import 'package:codefactory_flutte_project/restaurant/model/restaurant_model.dart';
import 'package:codefactory_flutte_project/restaurant/provider/restaurant_provier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skeletons/skeletons.dart';

class RestaurantDetailScreen extends ConsumerWidget {
  final String id;

  const RestaurantDetailScreen({
    super.key,
    required this.id,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(
      restaurantDetailProvider(id),
    );

    if (state == null) {
      return const DefaultLayout(
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
    return DefaultLayout(
      title: "떡뽂이",
      child: CustomScrollView(
        slivers: [
          randerTop(
            model: state,
          ),
          if (state is! RestaurantDetailModel) renderLoading(),
          if (state is RestaurantDetailModel) renderLabel(),
          if (state is RestaurantDetailModel)
            renderProducts(
              products: state.products,
            ),
        ],
      ),
    );
  }

  SliverPadding renderLoading() {
    return SliverPadding(
      padding: const EdgeInsets.all(
        16.0,
      ),
      sliver: SliverList(
        delegate: SliverChildListDelegate(
          List.generate(
            3,
            (index) => Padding(
              padding: const EdgeInsets.only(bottom: 32.0),
              child: SkeletonParagraph(
                style: const SkeletonParagraphStyle(
                  lines: 5,
                  padding: EdgeInsets.zero,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  SliverToBoxAdapter randerTop({required RestaurantModel model}) {
    return SliverToBoxAdapter(
      child: RestaurantCard.fromModel(
        model: model,
        isDetail: true,
      ),
    );
  }

  SliverPadding renderProducts(
      {required List<RestaurantProductModel> products}) {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate(
          childCount: products.length,
          (context, index) {
            final model = products[index];

            return Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: ProductCard.fromModel(model: model),
            );
          },
        ),
      ),
    );
  }

  SliverPadding renderLabel() {
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
