import 'package:meta/meta.dart';
import '../../helper/jwt_decoder.dart';

class AccessTokenPayload {
  String role;
  String iss;
  int exp;
  int iat;

  AccessTokenPayload({
    @required this.role,
    @required this.iss,
    @required this.exp,
    @required this.iat,
  });

  factory AccessTokenPayload.fromAccessToken(String accessToken) {
    Map<String, dynamic> payload = JwtDecoder.getPayload(accessToken);
    String role = payload['role'] as String;
    String iss = payload['iss'] as String;
    int exp = payload['exp'] as int;
    int iat = payload['iat'] as int;

    return AccessTokenPayload(role: role, iss: iss, exp: exp, iat: iat);
  }
}
