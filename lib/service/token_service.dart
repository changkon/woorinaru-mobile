import 'package:logging/logging.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

import './localstorage_service.dart';
import './authentication_service.dart';
import './identity_provider_service.dart';

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
  Future<String> getAccessToken() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.clear();
    String localAccessToken = await localStorageService.getAccessToken();

    if (localAccessToken != null) {
      log.fine('Retrieved local access token: $localAccessToken');
      return localAccessToken;
    }

    String localIdToken = await localStorageService.getIdToken();

    if (localIdToken != null) {
      String userAccessToken = await this.authenticationService.getUserAccessToken(localIdToken);
      await this.localStorageService.saveAccessToken(userAccessToken);
      log.fine('Retrieved user access token: $userAccessToken');
      return userAccessToken;
    }

    String visitorAccessToken = await this.authenticationService.getVisitorAccessToken();
    await this.localStorageService.saveAccessToken(visitorAccessToken);
    log.fine('Retrieved visitor access token: $visitorAccessToken');
    return visitorAccessToken;
  }

  Future<String> refreshAccessToken(String refreshToken) {
    // TODO
    return null;
  }

  Future<String> getIdToken(String provider) async {
    // TODO
    return null;
  }

  Future<String> getLocalIdToken() async {
    String idToken = await this.localStorageService.getIdToken();
    if (idToken != null) {
      log.fine('Retrieved local id token: $idToken');
      return idToken;
    }
    return null;
  }
}
