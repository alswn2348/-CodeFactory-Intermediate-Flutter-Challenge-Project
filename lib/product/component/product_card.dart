import 'package:codefactory_flutte_project/common/const/colors.dart';
import 'package:codefactory_flutte_project/common/const/gaps.dart';
import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({super.key});

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
            child: Image.asset(
              "  asset/img/food/ddeok_bok_gi.jpg",
              width: 110,
              height: 110,
              fit: BoxFit.cover,
            ),
          ),
          Gaps.h16,
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: const [
                Text(
                  "떡볶이",
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  "전통떡뽁이 \n 짱이에요",
                  style: TextStyle(
                    overflow: TextOverflow.ellipsis,
                    color: BODY_TEXT_COLOR,
                    fontSize: 14.0,
                  ),
                ),
                Text(
                  "10000 원",
                  style: TextStyle(color: PRIMARY_COLOR, fontSize: 12.0),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
