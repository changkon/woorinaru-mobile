import 'package:dio/dio.dart';
import 'package:meta/meta.dart';
import 'package:logging/logging.dart';

import '../auth/token_service.dart';
import '../woorinaru_service.dart';

import '../../model/user/user.dart';

class StaffService extends WoorinaruService {
  Logger log = new Logger('StaffService');


  StaffService({
    @required String baseUrl,
    @required TokenService tokenService,
  }) : super(baseUrl: baseUrl, tokenService: tokenService);

  Future<User> getStaff(int id) async {
    log.info('Getting staff with id: $id');

    String url = '$baseUrl/staff/$id';
    Response response = await this.httpClient.get(url);

    if (response.data == null) {
      log.warning('There are no staff member with id: $id');
      return null;
    }

    User user = User.fromJson(response.data);
    return user;
  }
}
