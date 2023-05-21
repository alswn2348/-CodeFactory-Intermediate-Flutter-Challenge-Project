import 'package:codefactory_flutte_project/common/const/colors.dart';
import 'package:codefactory_flutte_project/common/const/data.dart';
import 'package:codefactory_flutte_project/common/const/gaps.dart';
import 'package:codefactory_flutte_project/common/layout/default_layout.dart';
import 'package:codefactory_flutte_project/common/view/root_tab.dart';
import 'package:codefactory_flutte_project/user/view/login_screen.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    checkToken();
  }

  void deleteToken() async {
    await stroage.deleteAll();
  }

  void checkToken() async {
    final refreshToken = await stroage.read(key: REFRESH_TOKEN_KEY);
    final accessToken = await stroage.read(key: ACCESS_TOKEN_KYE);

    if (refreshToken == null || accessToken == null) {
      if (!mounted) return;
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (_) => const LoginScreen(),
          ),
          (route) => false);
    } else {
      if (!mounted) return;
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (_) => const RootTab(),
          ),
          (route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      backgroundColor: PRIMARY_COLOR,
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'asset/img/logo/logo.png',
              width: MediaQuery.of(context).size.width / 2,
            ),
            Gaps.v16,
            const CircularProgressIndicator(
              color: Colors.white,
            )
          ],
        ),
      ),
    );
  }
}
