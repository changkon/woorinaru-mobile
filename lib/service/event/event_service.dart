import 'package:dio/dio.dart';
import 'package:logging/logging.dart';
import 'package:meta/meta.dart';

import '../woorinaru_service.dart';
import '../auth/token_service.dart';

import '../../model/event/event.dart';

class EventService extends WoorinaruService {

  Logger log = new Logger('EventService');

  EventService({
    @required String baseUrl,
    @required TokenService tokenService,
  }) : super(baseUrl: baseUrl, tokenService: tokenService);

  Future<bool> createEvent(Event event) async {
    log.info('Creating event');
    String url = '$baseUrl/event';

    Response response = await this.httpClient.post(url, data: event.toJson());
    
    if (response.statusCode == 201) {
      return true;
    } else {
      return false;
    }
  }

  Future<Event> getEvent(int id) async {
    String url = '$baseUrl/event/$id';
    Response response = await this.httpClient.get(url);

    if (response.data == null) {
      return null;
    }

    Event event = Event.fromJson(response.data);
    return event;
  }

  Future<List<Event>> getAllEvents() async {
    String url = '$baseUrl/event';
    Response response = await this.httpClient.get(url);

    if (response.data == null) {
      log.warning('There are no events');
      return [];
    }

    List<Event> events = [];
    List<dynamic> jsonResponse = response.data;

    jsonResponse.forEach((json) {
      events.add(Event.fromJson(json));
    });

    return events;
  }

  Future<bool> deleteEvent(int id) async {
    log.info('Deleting event with id: $id');
    String url = '$baseUrl/event/$id';
    Response response = await this.httpClient.delete(url);
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> modifyEvent(Event event) async {
    log.info('Modifying event with id: ${event.id}');
    String url = '$baseUrl/event';

    Response response = await this.httpClient.put(url, data: event.toJson());
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

}
