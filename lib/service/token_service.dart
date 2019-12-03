import 'package:logging/logging.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

import './localstorage_service.dart';
import './authentication_service.dart';
import './identity_provider_service.dart';
import '../helper/jwt_decoder.dart';

class TokenService {
  final Logger log = new Logger('TokenService');

  AuthenticationService authenticationService;
  LocalStorageService localStorageService;
  IdentityProviderService identityProviderService;

  TokenService({
    @required this.authenticationService,
    @required this.localStorageService,
    @required this.identityProviderService,
  });

  /// Manages retrieving the access token and persists.
  /// 1. Check and return the local storage for existing access token
  /// 2. Check the local storage for existing id token
  /// 3. Create access token based on id token or create a visitor access token
  Future<String> generateAccessToken({ String idToken, String refreshToken }) async {
    if (idToken != null && refreshToken != null) {
      return await _generateUserAccessToken(idToken, refreshToken);
    }
    return await _generateVisitorAccessToken();
  }

  Future<String> _generateVisitorAccessToken() async {
    String visitorAccessToken = await this.authenticationService.getVisitorAccessToken();
    await this.localStorageService.saveAccessToken(visitorAccessToken);
    log.fine('Retrieved visitor access token: $visitorAccessToken');
    return visitorAccessToken;
  }

  Future<String> _generateUserAccessToken(String idToken, String refreshToken) async {
    String userAccessToken;
    try {
      userAccessToken = await this.authenticationService.getUserAccessToken(idToken);
    } catch (Exception) {
      // Use refresh token to renew id token and retry
      String idToken = await refreshIdToken(refreshToken);
      userAccessToken = await this.authenticationService.getUserAccessToken(idToken);
    }

    await this.localStorageService.saveAccessToken(userAccessToken);
    log.fine('Retrieved user access token: $userAccessToken');
    return userAccessToken;
  }

  Future<String> refreshAccessToken({ String idToken, String refreshToken }) async {
    await this.localStorageService.removeAccessToken();
    await this.localStorageService.removeIdToken();
    await this.localStorageService.removeIdRefreshToken();
    return await generateAccessToken(idToken: idToken, refreshToken: refreshToken);
  }

  Future<String> generateIdToken(String provider) async {
    // TODO
    return null;
  }

  Future<String> refreshIdToken(String refreshToken) async {
    // TODO
    return null;
  }

  Future<String> getLocalIdToken() async {
    String idToken = await this.localStorageService.getIdToken();
    return idToken;
  }

  Future<String> getLocalIdRefreshToken() async {
    String idRefreshToken = await this.localStorageService.getIdRefreshToken();
    return idRefreshToken;
  }

  Future<String> getLocalAccessToken() async {
    String accessToken = await this.localStorageService.getAccessToken();
    return accessToken;
  }

  bool verifyAccessToken(String accessToken) {
    Map<String, dynamic> payload = JwtDecoder.getPayload(accessToken);

    // Retrieve the expiry time
    int accessTokenExp = payload['exp'] as int;
    int currentTime = (((new DateTime.now()).millisecondsSinceEpoch) / 1000).round();
    String issuer = payload['iss'] as String;

    bool isWoorinaruIssuer = issuer == 'woorinaru';
    bool isExpired = currentTime >= accessTokenExp;

    return isWoorinaruIssuer && !isExpired;
  }
}
