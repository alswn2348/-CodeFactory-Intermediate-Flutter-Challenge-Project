import 'package:codefactory_flutte_project/common/const/sizes.dart';
import 'package:flutter/material.dart';

class DefaultLayout extends StatelessWidget {
  final Color? backgroundColor;
  final Widget child;
  final String? title;

  const DefaultLayout({
    super.key,
    required this.child,
    this.backgroundColor,
    this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor ?? Colors.white,
      appBar: randerAppBar(),
      body: child,
    );
  }

  AppBar? randerAppBar() {
    if (title != null) {
      return AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: Colors.black,
        title: Text(
          title!,
          style: const TextStyle(
            fontSize: Sizes.size16,
            fontWeight: FontWeight.w500,
          ),
        ),
      );
    }
    return null;
  }
}
