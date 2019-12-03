import 'package:dio/dio.dart';
import 'package:logging/logging.dart';
import 'package:meta/meta.dart';
import 'dart:convert';

import './woorinaru_service.dart';
import './token_service.dart';

import '../models/event/event.dart';

class EventService extends WoorinaruService {

  Logger log = new Logger('EventService');

  EventService({
    @required String baseUrl,
    @required TokenService tokenService,
  }) : super(baseUrl: baseUrl, tokenService: tokenService);

  Future<Event> getEvent(int id) async {
    String url = '$baseUrl/event/$id';
    Response response = await this.httpClient.get(url);

    if (response.data == null) {
      return null;
    }

    Event event = Event.fromJson(response.data);
    return event;
  }

}
