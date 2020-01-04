import 'package:dio/dio.dart';
import 'package:logging/logging.dart';
import 'package:meta/meta.dart';

import '../woorinaru_service.dart';
import '../auth/token_service.dart';

import '../../model/class/woorinaru_class.dart';

class BeginnerClassService extends WoorinaruService {
  Logger log = new Logger('BeginnerClassService');

  BeginnerClassService({
    @required String baseUrl,
    @required TokenService tokenService,
  }) : super(baseUrl: baseUrl, tokenService: tokenService);

  Future<bool> createBeginnerClass(WoorinaruClass woorinaruClass) async {
    log.info('Creating beginner class');
    String url = '$baseUrl/class/beginner';

    Response response = await this.httpClient.post(url, data: woorinaruClass.toJson());

    if (response.statusCode == 201) {
      return true;
    } else {
      return false;
    }
  }

  Future<WoorinaruClass> getBeginnerClass(int id) async {
    log.info('Retrieving beginner class with id: $id');
    String url = '$baseUrl/class/beginner/$id';

    Response response = await this.httpClient.get(url);

    if (response.data == null) {
      return null;
    }

    WoorinaruClass beginnerClass = WoorinaruClass.fromJson(response.data);
    return beginnerClass;
  }

  Future<List<WoorinaruClass>> getAllBeginnerClasses() async {
    log.info('Retrieving all beginner classes');
    String url = '$baseUrl/class/beginner';

    Response response = await this.httpClient.get(url);

    if (response.data == null) {
      log.warning('There are no beginner classes');
      return [];
    }

    List<WoorinaruClass> beginnerClasses = [];
    List<dynamic> jsonResponse = response.data;

    jsonResponse.forEach((json) {
      beginnerClasses.add(WoorinaruClass.fromJson(json));
    });

    return beginnerClasses;
  }

  Future<bool> deleteBeginnerClass(int id) async {
    log.info('Deleting beginner class with id: $id');
    String url = '$baseUrl/class/beginner/$id';

    Response response = await this.httpClient.delete(url);

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> modifyBeginnerClass(WoorinaruClass woorinaruClass) async {
    log.info('Modifying beginner class with id: ${woorinaruClass.id}');
    String url = '$baseUrl/class/beginner';

    Response response = await this.httpClient.put(url, data: woorinaruClass.toJson());

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

}
