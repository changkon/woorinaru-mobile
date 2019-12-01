import 'package:meta/meta.dart';

import '../../helper/jwt_decoder.dart';

enum UserType { STUDENT, STAFF, ADMIN }
enum StaffRole { LEADER, VICE_LEADER, SUB_LEADER, TEACHER }

class User {
  String name;
  String nickname;
  String picture;
  String email;
  UserType userType;
  StaffRole staffRole;

  User({
    @required this.name,
    @required this.nickname,
    @required this.picture,
    @required this.email,
    this.userType,
    this.staffRole,
  });

  factory User.fromIdToken(String idToken) {
    Map<String, dynamic> claims = JwtDecoder.getPayload(idToken);
    // Extract claims
    String name = claims['name'];
    String nickname = claims['nickname'];
    String picture = claims['picture'];
    String email = claims['email'];

    return User(name: name, nickname: nickname, picture: picture, email: email);
  }
}
