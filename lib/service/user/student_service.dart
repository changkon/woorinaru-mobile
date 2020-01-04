import 'package:dio/dio.dart';
import 'package:meta/meta.dart';
import 'package:logging/logging.dart';

import '../auth/token_service.dart';
import '../woorinaru_service.dart';

import '../../model/user/user.dart';

class StudentService extends WoorinaruService {
  Logger log = new Logger('StudentService');

  StudentService({
    @required String baseUrl,
    @required TokenService tokenService,
  }) : super(baseUrl: baseUrl, tokenService: tokenService);

  Future<bool> createStudent(User student) async {
    log.info('Creating student');
    String url = '$baseUrl/student';

    Response response = await this.httpClient.post(url, data: student.toJson());

    if (response.statusCode == 201) {
      return true;
    } else {
      return false;
    }
  }

  Future<User> getStudent(int id) async {
    log.info('Getting student with id: $id');

    String url = '$baseUrl/student/$id';
    Response response = await this.httpClient.get(url);

    if (response.data == null) {
      log.warning('There are no students with id: $id');
      return null;
    }

    User user = User.fromJson(response.data);
    return user;
  }

  Future<List<User>> getStudentList() async {
    log.info('Getting all student');

    String url = '$baseUrl/student';
    Response response = await this.httpClient.get(url);

    if (response.data == null) {
      log.warning('Invalid request');
      return null;
    }

    List<User> student = [];
    List<dynamic> jsonResponse = response.data;

    jsonResponse.forEach((json) {
      student.add(User.fromJson(json));
    });

    return student;
  }

  Future<bool> deleteStaff(int id) async {
    log.info('Deleting student with id: $id');

    String url = '$baseUrl/student/$id';
    Response response = await this.httpClient.delete(url);

    if (response.statusCode == 200) {
      // Success
      return true;
    } else {
      return false;
    }
  }

  Future<bool> modifyStaff(User student) async {
    log.info('Modifying student with id: ${student.id}');

    String url = '$baseUrl/student';

    Response response = await this.httpClient.put(url, data: student.toJson());

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
}
