import 'package:dio/dio.dart';
import 'package:logging/logging.dart';
import 'package:meta/meta.dart';

import '../woorinaru_service.dart';
import '../auth/token_service.dart';

import '../../model/class/woorinaru_class.dart';

class IntermediateClassService extends WoorinaruService {
  Logger log = new Logger('IntermediateClassService');

  IntermediateClassService({
    @required String baseUrl,
    @required TokenService tokenService,
  }) : super(baseUrl: baseUrl, tokenService: tokenService);

  Future<bool> createIntermediateClass(WoorinaruClass woorinaruClass) async {
    log.info('Creating intermediate class');
    String url = '$baseUrl/class/intermediate';

    Response response = await this.httpClient.post(url, data: woorinaruClass.toJson());

    if (response.statusCode == 201) {
      return true;
    } else {
      return false;
    }
  }

  Future<WoorinaruClass> getIntermediateClass(int id) async {
    log.info('Retrieving intermediate class with id: $id');
    String url = '$baseUrl/class/intermediate/$id';

    Response response = await this.httpClient.get(url);

    if (response.data == null) {
      return null;
    }

    WoorinaruClass intermediateClass = WoorinaruClass.fromJson(response.data);
    return intermediateClass;
  }

  Future<List<WoorinaruClass>> getAllIntermediateClasses() async {
    log.info('Retrieving all intermediate classes');
    String url = '$baseUrl/class/intermediate';

    Response response = await this.httpClient.get(url);

    if (response.data == null) {
      log.warning('There are no intermediate classes');
      return [];
    }

    List<WoorinaruClass> intermediateClasses = [];
    List<dynamic> jsonResponse = response.data;

    jsonResponse.forEach((json) {
      intermediateClasses.add(WoorinaruClass.fromJson(json));
    });

    return intermediateClasses;
  }

  Future<bool> deleteIntermediateClass(int id) async {
    log.info('Deleting intermediate class with id: $id');
    String url = '$baseUrl/class/intermediate/$id';

    Response response = await this.httpClient.delete(url);

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> modifyIntermediateClass(WoorinaruClass woorinaruClass) async {
    log.info('Modifying intermediate class with id: ${woorinaruClass.id}');
    String url = '$baseUrl/class/intermediate';

    Response response = await this.httpClient.put(url, data: woorinaruClass.toJson());

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

}
