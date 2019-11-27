class WoorinaruAccessToken {
  final String token;

  WoorinaruAccessToken(this.token);

  factory WoorinaruAccessToken.fromJson(Map<String, dynamic> json) {
    return WoorinaruAccessToken(json['token'] as String);
  }
}
