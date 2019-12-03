import 'package:dio/dio.dart';
import 'package:logging/logging.dart';
import 'package:meta/meta.dart';

import '../service/woorinaru_service.dart';
import '../service/token_service.dart';

class TermService extends WoorinaruService {

  Logger log = new Logger('TermService');

  TermService({
    @required String baseUrl,
    @required TokenService tokenService,
  }) : super(baseUrl: baseUrl, tokenService: tokenService);

  void getAllTerms() async {
    log.info('Getting all terms');
    String url = '$baseUrl/term';
    Response response = await this.httpClient.get(url);
    print(response.data);
  }

  Future<int> getLatestTermId() async {
    String url = '$baseUrl/term';
    Response response = await this.httpClient.get(url);
    List<dynamic> terms = response.data;

    if (terms.isEmpty) {
      return null;
    }

    int latestTerm = terms.fold(terms.first['id'] as int,
      (latest, current) => latest > (current['id'] as int) ? latest : (current['id'] as int));
    return latestTerm;
  }
}
