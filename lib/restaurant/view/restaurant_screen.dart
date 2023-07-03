import 'package:codefactory_flutte_project/common/const/sizes.dart';
import 'package:codefactory_flutte_project/common/model/cursor_pagination_model.dart';
import 'package:codefactory_flutte_project/common/utils/pagination_utils.dart';
import 'package:codefactory_flutte_project/restaurant/component/restaurant_card.dart';
import 'package:codefactory_flutte_project/restaurant/provider/restaurant_provier.dart';
import 'package:codefactory_flutte_project/restaurant/view/restaurant_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RestaurantScreen extends ConsumerStatefulWidget {
  const RestaurantScreen({super.key});

  @override
  ConsumerState<RestaurantScreen> createState() => _RestaurantScreenState();
}

class _RestaurantScreenState extends ConsumerState<RestaurantScreen> {
  final ScrollController controller = ScrollController();

  @override
  void initState() {
    super.initState();

    controller.addListener(scrollListener);
  }

  void scrollListener() {
    /*    if (controller.offset > controller.position.maxScrollExtent) {
      ref.read(restaurantProvider.notifier).paginate(
            fetchMore: true,
          );
    } */
    PaginationUtils.paginate(
      controller: controller,
      provider: ref.read(restaurantProvider.notifier),
    );
  }

  @override
  Widget build(BuildContext context) {
    final data = ref.watch(restaurantProvider);

    if (data is CursorPaginationLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    if (data is CursorpaginationError) {
      return Center(
        child: Text(
          data.message,
        ),
      );
    }

    //

    final cp = data as CursorPagination;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: ListView.separated(
        controller: controller,
        itemBuilder: (_, index) {
          if (index == cp.data.length) {
            return Center(
              child: data is CursorpaginationFetchingMore
                  ? const CircularProgressIndicator()
                  : const Text(
                      "더 이상 데이터가 없습니다.",
                    ),
            );
          }

          final pItem = cp.data[index];

          return GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => RestaurantDetailScreen(
                    id: pItem.id,
                  ),
                ),
              );
            },
            child: RestaurantCard.fromModel(model: pItem),
          );
        },
        separatorBuilder: (_, index) {
          return const SizedBox(
            height: Sizes.size16,
          );
        },
        itemCount: cp.data.length + 1,
      ),
    );
  }
}
