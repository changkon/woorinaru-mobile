import 'package:dio/dio.dart';
import 'package:meta/meta.dart';
import 'package:logging/logging.dart';

import '../auth/token_service.dart';
import '../woorinaru_service.dart';

import '../../model/user/user.dart';

class AdminService extends WoorinaruService {
  Logger log = new Logger('AdminService');

  AdminService({
    @required String baseUrl,
    @required TokenService tokenService,
  }) : super(baseUrl: baseUrl, tokenService: tokenService);

  Future<bool> createAdmin(User admin) async {
    log.info('Creating admin');
    String url = '$baseUrl/admin';

    Response response = await this.httpClient.post(url, data: admin.toJson());

    if (response.statusCode == 201) {
      return true;
    } else {
      return false;
    }
  }

  Future<User> getAdmin(int id) async {
    log.info('Getting admin with id: $id');

    String url = '$baseUrl/admin/$id';
    Response response = await this.httpClient.get(url);

    if (response.data == null) {
      log.warning('There are no admins with id: $id');
      return null;
    }

    User user = User.fromJson(response.data);
    return user;
  }

  Future<List<User>> getAdminList() async {
    log.info('Getting all admin');

    String url = '$baseUrl/admin';
    Response response = await this.httpClient.get(url);

    if (response.data == null) {
      log.warning('Invalid request');
      return null;
    }

    List<User> admin = [];
    List<dynamic> jsonResponse = response.data;

    jsonResponse.forEach((json) {
      admin.add(User.fromJson(json));
    });

    return admin;
  }

  Future<bool> deleteStaff(int id) async {
    log.info('Deleting admin with id: $id');

    String url = '$baseUrl/admin/$id';
    Response response = await this.httpClient.delete(url);

    if (response.statusCode == 200) {
      // Success
      return true;
    } else {
      return false;
    }
  }

  Future<bool> modifyStaff(User admin) async {
    log.info('Modifying admin with id: ${admin.id}');

    String url = '$baseUrl/admin';

    Response response = await this.httpClient.put(url, data: admin.toJson());

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
}
