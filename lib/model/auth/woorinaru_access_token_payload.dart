import 'package:meta/meta.dart';
import '../../util/jwt/jwt_decoder.dart';

class WoorinaruAccessTokenPayload {
  String role;
  String iss;
  int exp;
  int iat;

  WoorinaruAccessTokenPayload({
    @required this.role,
    @required this.iss,
    @required this.exp,
    @required this.iat,
  });

  factory WoorinaruAccessTokenPayload.fromAccessToken(String accessToken) {
    Map<String, dynamic> payload = JwtDecoder.getPayload(accessToken);
    String role = payload['role'] as String;
    String iss = payload['iss'] as String;
    int exp = payload['exp'] as int;
    int iat = payload['iat'] as int;

    return WoorinaruAccessTokenPayload(role: role, iss: iss, exp: exp, iat: iat);
  }
}
