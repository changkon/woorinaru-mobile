import 'package:dio/dio.dart';
import 'package:logging/logging.dart';
import 'package:meta/meta.dart';

import '../woorinaru_service.dart';
import '../auth/token_service.dart';

import '../../model/class/woorinaru_class.dart';

class TutoringClassService extends WoorinaruService {
  Logger log = new Logger('TutoringClassService');

  TutoringClassService({
    @required String baseUrl,
    @required TokenService tokenService,
  }) : super(baseUrl: baseUrl, tokenService: tokenService);

  Future<bool> createTutoringClass(WoorinaruClass woorinaruClass) async {
    log.info('Creating tutoring class');
    String url = '$baseUrl/class/tutoring';

    Response response = await this.httpClient.post(url, data: woorinaruClass.toJson());

    if (response.statusCode == 201) {
      return true;
    } else {
      return false;
    }
  }

  Future<WoorinaruClass> getTutoringClass(int id) async {
    log.info('Retrieving tutoring class with id: $id');
    String url = '$baseUrl/class/tutoring/$id';

    Response response = await this.httpClient.get(url);

    if (response.data == null) {
      return null;
    }

    WoorinaruClass tutoringClass = WoorinaruClass.fromJson(response.data);
    return tutoringClass;
  }

  Future<List<WoorinaruClass>> getAllTutoringClasses() async {
    log.info('Retrieving all tutoring classes');
    String url = '$baseUrl/class/tutoring';

    Response response = await this.httpClient.get(url);

    if (response.data == null) {
      log.warning('There are no tutoring classes');
      return [];
    }

    List<WoorinaruClass> tutoringClasses = [];
    List<dynamic> jsonResponse = response.data;

    jsonResponse.forEach((json) {
      tutoringClasses.add(WoorinaruClass.fromJson(json));
    });

    return tutoringClasses;
  }

  Future<bool> deleteTutoringClass(int id) async {
    log.info('Deleting tutoring class with id: $id');
    String url = '$baseUrl/class/tutoring/$id';

    Response response = await this.httpClient.delete(url);

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> modifyTutoringClass(WoorinaruClass woorinaruClass) async {
    log.info('Modifying tutoring class with id: ${woorinaruClass.id}');
    String url = '$baseUrl/class/tutoring';

    Response response = await this.httpClient.put(url, data: woorinaruClass.toJson());

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

}
