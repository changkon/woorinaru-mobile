import 'package:meta/meta.dart';
import 'package:dio/dio.dart';
import '../../model/auth/woorinaru_access_token.dart';

class AuthenticationService {
  final String baseUrl;
  String _endpoint;

  AuthenticationService({
    @required this.baseUrl,
  }) {
    this._endpoint = this.baseUrl + '/authenticate';
  }

  Future<String> getVisitorAccessToken() async {
    Response response = await new Dio().post(_endpoint);
    if (response.statusCode == 200) {
      Map tokenMap = response.data;
      WoorinaruAccessToken accessToken =
          WoorinaruAccessToken.fromJson(tokenMap);
      return accessToken.token;
    }
    return null;
  }

  Future<String> getUserAccessToken(String idToken) async {
    Map<String, String> headers = {'Authorization': 'Bearer ' + idToken};
    Response response = await new Dio().post(
      _endpoint,
      options: Options(
        headers: headers,
      ),
    );
    if (response.statusCode == 200) {
      Map tokenMap = response.data;
      WoorinaruAccessToken accessToken =
          WoorinaruAccessToken.fromJson(tokenMap);
      return accessToken.token;
    }
    return null;
  }
}
