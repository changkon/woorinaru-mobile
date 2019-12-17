import 'package:meta/meta.dart';

import '../../util/jwt/jwt_decoder.dart';
import './user.dart';

class Client extends User {
  String nickname;
  String picture;

  Client({
    @required name,
    @required this.nickname,
    @required this.picture,
    @required email
  }) : super(name: name, email: email);

  factory Client.fromIdToken(String idToken) {
    Map<String, dynamic> claims = JwtDecoder.getPayload(idToken);
    // Extract claims
    String name = claims['name'];
    String nickname = claims['nickname'];
    String picture = claims['picture'];
    String email = claims['email'];

    return Client(name: name, nickname: nickname, picture: picture, email: email);
  }
}
