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
        {'accessToken': "Bearer $token"},
      );
    }

    super.onRequest(options, handler);
  }

  //응답을 받을때
  //에러났을때
  @override
  void onError(DioError err, ErrorInterceptorHandler handler) async {
    super.onError(err, handler);

    //status code 401
    final refreshToken = await stroage.read(key: REFRESH_TOKEN_KEY);

    if (refreshToken == null) {
      return handler.reject(err); //에러 반환
    }
    final isStatus401 = err.response?.statusCode == 401;
    final isPathRefresh = err.requestOptions.path == '/auth/token';

    try {
      if (isStatus401 && !isPathRefresh) {
        final dio = Dio();
        final resp = await dio.post(
          "http://$ip/auth/token",
          options: Options(
            headers: {
              'authorization': 'Bearer $refreshToken',
            },
          ),
        );
        final accessToken = resp.data['accessToken'];

        final options = err.requestOptions;

        options.headers.addAll(
          {
            'authorization': 'Bearer $accessToken',
          },
        );

        await stroage.write(key: ACCESS_TOKEN_KYE, value: accessToken);

        final respons = await dio.fetch(options); //재전송

        return handler.resolve(respons); //response 반환
      }
    } on DioError catch (e) {
      return handler.reject(e);
    }
  }
}
