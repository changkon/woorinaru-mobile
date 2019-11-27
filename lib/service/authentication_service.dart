import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';
import '../models/auth/woorinaru_access_token.dart';

class AuthenticationService {
  final String baseUrl;
  String _endpoint;

  AuthenticationService({
    @required this.baseUrl,
  }) {
    this._endpoint = this.baseUrl + '/authenticate';
  }

  Future<String> getVisitorAccessToken() async {
    http.Response response = await http.post(_endpoint);
    if (response.statusCode == 200) {
      Map tokenMap = jsonDecode(response.body);
      WoorinaruAccessToken accessToken = WoorinaruAccessToken.fromJson(tokenMap);
      return accessToken.token;
    }
    return null;
  }

  Future<String> getUserAccessToken(String idToken) async {
    Map<String, String> headers = {'Authorization': 'Bearer ' + idToken};
    http.Response response = await http.post(_endpoint, headers: headers);
    if (response.statusCode == 200) {
      Map tokenMap = jsonDecode(response.body);
      WoorinaruAccessToken accessToken = WoorinaruAccessToken.fromJson(tokenMap);
      return accessToken.token;
    }
    return null;
  }
}
