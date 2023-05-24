import 'package:codefactory_flutte_project/common/const/colors.dart';
import 'package:codefactory_flutte_project/common/layout/default_layout.dart';
import 'package:codefactory_flutte_project/restaurant/view/restaurant_screen.dart';
import 'package:flutter/material.dart';

class RootTab extends StatefulWidget {
  const RootTab({super.key});

  @override
  State<RootTab> createState() => _RootTabState();
}

class _RootTabState extends State<RootTab> with SingleTickerProviderStateMixin {
  late TabController _controller;

  //int index = 0;

  @override
  void initState() {
    super.initState();
    _controller = TabController(
        length: 4, vsync: this); //SingleTickerProviderStateMixin 필요

    //_controller.addListener(tabListener);
  }

  @override
  void dispose() {
    //_controller.removeListener(tabListener);
    _controller.dispose();
    super.dispose();
  }

  /* void tabListener() {
    setState(() {
      index = _controller.index;
    });
  } */

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      title: "딜리버리 타이틀 연습",
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: PRIMARY_COLOR,
        unselectedItemColor: BODY_TEXT_COLOR,
        selectedFontSize: 10,
        unselectedFontSize: 10,
        type: BottomNavigationBarType.fixed, // shifting 은 선택 강조
        onTap: (value) {
          _controller.animateTo(value);
          setState(() {});
        },
        currentIndex: _controller.index,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: '홈',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.fastfood_outlined),
            label: '음식',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.receipt_long_outlined),
            label: '주문',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: '프로필',
          ),
        ],
      ),
      child: TabBarView(
        physics: const NeverScrollableScrollPhysics(), //스크롤 기능 정지
        controller: _controller,
        children: [
          const RestaurantScreen(),
          Container(
            child: const Text("2"),
          ),
          Container(
            child: const Text("3"),
          ),
          Container(
            child: const Text("4"),
          ),
        ],
      ),
    );
  }
}
