import 'package:dio/dio.dart';
import 'package:logging/logging.dart';
import 'package:meta/meta.dart';
import 'dart:convert';

import '../service/woorinaru_service.dart';
import '../service/token_service.dart';
import '../models/term/term.dart';

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

  Future<Term> getTerm(int id) async {
    log.info('Getting term with id: $id');
    String url ='$baseUrl/term/$id';
    Response response = await this.httpClient.get(url);
    if (response.data == null) {
      log.warning('Term with id: $id not found');
      return null;
    }
    
    Term term = Term.fromJson(response.data);
    return term;
  }

  Future<int> getLatestTermId() async {
    String url = '$baseUrl/term';
    Response response = await this.httpClient.get(url);
    List<dynamic> terms = response.data;

    if (terms.isEmpty) {
      return null;
    }

    // int latestTerm = terms.fold(terms.first['id'] as int,
    //   (latest, current) => latest > (current['term'] as int) ? latest : (current['term'] as int));

    int latestTermId = terms.first['id'];
    int latestTerm = terms.first['term'];

    for (int i = 1; i < terms.length; i++) {
      int currentTermId = terms[i]['id'];
      int currentTerm = terms[i]['term'];
      if (currentTerm > latestTerm) {
        latestTermId = currentTermId;
        latestTerm = currentTerm;
      }
    }
    
    return latestTermId;
  }
}
