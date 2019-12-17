import 'package:dio/dio.dart';
import 'package:logging/logging.dart';
import 'package:meta/meta.dart';

import '../auth/token_service.dart';
import '../woorinaru_service.dart';

class ResourceService extends WoorinaruService {
  Logger log = new Logger('ResourceService');

  ResourceService({
    @required String baseUrl,
    @required TokenService tokenService,
  }) : super(
          baseUrl: baseUrl,
          tokenService: tokenService,
        );
  
  Future<String> getResourceDescription(int id) async {
    String url = '$baseUrl/resource/description/$id';
    Response response = await this.httpClient.get(url);

    if (response.data == null) {
      return null;
    }

    return response.data as String;
  }
}
