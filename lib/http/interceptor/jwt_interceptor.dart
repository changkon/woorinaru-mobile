import 'package:dio/dio.dart';
import 'package:logging/logging.dart';
import 'package:meta/meta.dart';

import '../../service/token_service.dart';

class JwtInterceptor extends InterceptorsWrapper {

  final Logger log = new Logger('JwtInterceptor');

  TokenService tokenService;
  Dio httpClient;

  JwtInterceptor({
    @required this.tokenService,
    @required this.httpClient,
  });

  @override
  Future onRequest(RequestOptions options) async {
    log.info("REQUEST[${options?.method}] => PATH: ${options?.path}");

    // Adds valid access tokens to requests
    String accessToken = await this.tokenService.getLocalAccessToken();

    if (accessToken == null) {
      String idToken = await this.tokenService.getLocalIdToken();
      String refreshToken = await this.tokenService.getLocalIdRefreshToken();
      accessToken = await this.tokenService.generateAccessToken(idToken: idToken, refreshToken: refreshToken);
    }

    bool validAccessToken = this.tokenService.verifyAccessToken(accessToken);
    if (!validAccessToken) {
      // Get new access token through local id token
      // lock request until other requests have been processed
      this.httpClient.lock();
      String idToken = await this.tokenService.getLocalIdToken();
      String refreshToken = await this.tokenService.getLocalIdRefreshToken();
      accessToken = await this.tokenService.refreshAccessToken(idToken: idToken, refreshToken: refreshToken);
      this.httpClient.unlock();
    }

    // Add token
    String bearerToken = 'Bearer $accessToken';
    options.headers['Authorization'] = bearerToken;
    return super.onRequest(options);
  }
  @override
  Future onResponse(Response response) {
    log.info('Response: ${response.data}');
    return super.onResponse(response);
  }
  @override
  Future onError(DioError err) {
    log.severe("ERROR[${err?.response?.statusCode}] => PATH: ${err?.request?.path}");
    return super.onError(err);
  }

}
