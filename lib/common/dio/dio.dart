import 'package:codefactory_flutte_project/common/const/data.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class CustomInterceptor extends Interceptor {
  final FlutterSecureStorage storage;

  CustomInterceptor({
    required this.storage,
  });

  //요청을 보낼때
  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    if (options.headers['accessToken'] == "true") {
      options.headers.remove('accessToken');

      final token = await storage.read(key: ACCESS_TOKEN_KYE);

      options.headers.addAll(
        {'accessToken': token},
      );
    }

    super.onRequest(options, handler);
  }
  //응답을 받을때
  //에러났을때
}
