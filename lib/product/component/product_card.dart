import 'package:codefactory_flutte_project/common/const/colors.dart';
import 'package:codefactory_flutte_project/common/const/gaps.dart';
import 'package:codefactory_flutte_project/restaurant/model/restaurant_detail_model.dart';
import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  final Image imgae;
  final String name;
  final String detail;
  final int price;

  const ProductCard({
    super.key,
    required this.imgae,
    required this.name,
    required this.detail,
    required this.price,
  });

  factory ProductCard.fromModel({required RestaurantProductModel model}) {
    return ProductCard(
      imgae: Image.network(
        model.imgUrl,
        width: 110,
        height: 110,
        fit: BoxFit.cover,
      ),
      name: model.name,
      detail: model.detail,
      price: model.price,
    );
  }

  @override
  Widget build(BuildContext context) {
    // 자식의 크기를 자식의 고유 높이로 조정하는 위젯을 만듭니다. (효율 나쁨)
    return IntrinsicHeight(
      child: Row(
        children: [
          ClipRRect(
              borderRadius: BorderRadius.circular(
                8.0,
              ),
              child: imgae),
          Gaps.h16,
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  detail,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: BODY_TEXT_COLOR,
                    fontSize: 14.0,
                  ),
                ),
                Text(
                  "$price 원",
                  style: const TextStyle(
                    color: PRIMARY_COLOR,
                    fontSize: 12.0,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
