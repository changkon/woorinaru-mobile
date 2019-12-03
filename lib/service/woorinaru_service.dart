import 'package:meta/meta.dart';
import 'package:dio/dio.dart';
import 'package:woorinaru/http/interceptor/jwt_interceptor.dart';
import 'package:woorinaru/service/token_service.dart';

abstract class WoorinaruService {
  String baseUrl;
  Dio httpClient;

  WoorinaruService({
    @required this.baseUrl,
    @required TokenService tokenService,
  }) {
    this.httpClient = new Dio();
    this.httpClient.interceptors.add(
          JwtInterceptor(
            tokenService: tokenService,
            httpClient: this.httpClient,
          ),
        );
  }
}
