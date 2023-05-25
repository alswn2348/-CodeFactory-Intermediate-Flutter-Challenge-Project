import 'dart:convert';
import 'dart:io';

import 'package:codefactory_flutte_project/common/component/custom_text_form_field.dart';
import 'package:codefactory_flutte_project/common/const/colors.dart';
import 'package:codefactory_flutte_project/common/const/data.dart';
import 'package:codefactory_flutte_project/common/const/gaps.dart';
import 'package:codefactory_flutte_project/common/layout/default_layout.dart';
import 'package:codefactory_flutte_project/common/view/root_tab.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String username = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    final dio = Dio();

    const emulatorIp = '10.0.2.2:3000';
    const simulatorIp = '127.0.0.1:3000';

    final ip = Platform.isIOS == true ? simulatorIp : emulatorIp;

    return DefaultLayout(
      child: SingleChildScrollView(
        keyboardDismissBehavior:
            ScrollViewKeyboardDismissBehavior.onDrag, //드래그 했을때 키보드 dismiss
        child: SafeArea(
          top: true,
          bottom: false,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const _Title(),
                Gaps.v16,
                const _SubTitle(),
                Image.asset(
                  'asset/img/misc/logo.png',
                  height: MediaQuery.of(context).size.height / 5 * 2,
                ),
                Gaps.v16,
                CustomTextFormField(
                  hintText: "이메일을 입력해주세요",
                  onChanged: (String value) {
                    username = value;
                  },
                ),
                Gaps.v16,
                CustomTextFormField(
                  hintText: "비밀번호를 입력해주세요",
                  onChanged: (String value) {
                    password = value;
                  },
                  obscureText: true,
                ),
                Gaps.v16,
                ElevatedButton(
                  onPressed: () async {
                    final rawString = '$username:$password'; //id : 비밀번호

                    Codec<String, String> stringToBase64 =
                        utf8.fuse(base64); //String 을 Base64 로 바꿔주는 코덱

                    String token = stringToBase64.encode(rawString); //인코딩

                    final resp = await dio.post(
                      'http://$ip/auth/login',
                      options:
                          Options(headers: {'authorization': 'Basic $token'}),
                    );
                    final refreshToken = resp.data['refreshToken'];
                    final accessToken = resp.data['accessToken'];

                    await stroage.write(
                        key: REFRESH_TOKEN_KEY, value: refreshToken);
                    await stroage.write(
                        key: ACCESS_TOKEN_KYE, value: accessToken);

                    if (!mounted) return;
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => const RootTab(),
                      ),
                    );
                  },
                  style:
                      ElevatedButton.styleFrom(backgroundColor: PRIMARY_COLOR),
                  child: const Text("로그인"),
                ),
                TextButton(
                  onPressed: () async {
                  
               
                  },
                  style: TextButton.styleFrom(foregroundColor: Colors.black),
                  child: const Text("회원가입"),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _SubTitle extends StatelessWidget {
  const _SubTitle();

  @override
  Widget build(BuildContext context) {
    return const Text(
      '이메일과 비밀번호를 입력해주세요!\n오늘도 성공적인 주문이 되길 ^ㅗ^',
      style: TextStyle(fontSize: 16, color: BODY_TEXT_COLOR),
    );
  }
}

class _Title extends StatelessWidget {
  const _Title();

  @override
  Widget build(BuildContext context) {
    return const Text(
      "환영합니다.",
      style: TextStyle(
        fontSize: 34,
        fontWeight: FontWeight.w500,
        color: Colors.black,
      ),
    );
  }
}
