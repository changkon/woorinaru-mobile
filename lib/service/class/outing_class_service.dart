import 'package:dio/dio.dart';
import 'package:logging/logging.dart';
import 'package:meta/meta.dart';

import '../woorinaru_service.dart';
import '../auth/token_service.dart';

import '../../model/class/woorinaru_class.dart';

class OutingClassService extends WoorinaruService {
  Logger log = new Logger('OutingClassService');

  OutingClassService({
    @required String baseUrl,
    @required TokenService tokenService,
  }) : super(baseUrl: baseUrl, tokenService: tokenService);

  Future<bool> createOutingClass(WoorinaruClass woorinaruClass) async {
    log.info('Creating outing class');
    String url = '$baseUrl/class/outing';

    Response response = await this.httpClient.post(url, data: woorinaruClass.toJson());

    if (response.statusCode == 201) {
      return true;
    } else {
      return false;
    }
  }

  Future<WoorinaruClass> getOutingClass(int id) async {
    log.info('Retrieving outing class with id: $id');
    String url = '$baseUrl/class/outing/$id';

    Response response = await this.httpClient.get(url);

    if (response.data == null) {
      return null;
    }

    WoorinaruClass outingClass = WoorinaruClass.fromJson(response.data);
    return outingClass;
  }

  Future<List<WoorinaruClass>> getAllOutingClasses() async {
    log.info('Retrieving all outing classes');
    String url = '$baseUrl/class/outing';

    Response response = await this.httpClient.get(url);

    if (response.data == null) {
      log.warning('There are no outing classes');
      return [];
    }

    List<WoorinaruClass> outingClasses = [];
    List<dynamic> jsonResponse = response.data;

    jsonResponse.forEach((json) {
      outingClasses.add(WoorinaruClass.fromJson(json));
    });

    return outingClasses;
  }

  Future<bool> deleteOutingClass(int id) async {
    log.info('Deleting outing class with id: $id');
    String url = '$baseUrl/class/outing/$id';

    Response response = await this.httpClient.delete(url);

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> modifyOutingClass(WoorinaruClass woorinaruClass) async {
    log.info('Modifying outing class with id: ${woorinaruClass.id}');
    String url = '$baseUrl/class/outing';

    Response response = await this.httpClient.put(url, data: woorinaruClass.toJson());

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

}
