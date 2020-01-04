import 'package:intl/intl.dart';

import '../user/user.dart';
import '../class/woorinaru_class.dart';

class Event {
  int id;
  DateTime startDateTime;
  DateTime endDateTime;
  String address;
  String description;

  List<int> studentReservationIds;
  List<int> wooriClassIds;

  List<User> studentReservations;
  List<WoorinaruClass> wooriClasses;

  Event({
    this.id,
    this.startDateTime,
    this.endDateTime,
    this.address,
    this.description,
    this.studentReservationIds,
    this.wooriClassIds,
    this.studentReservations,
    this.wooriClasses,
  });

  factory Event.fromJson(Map<String, dynamic> json) {
    int id = json['id'] as int;
    DateTime startDateTime = DateTime.parse(json['startDateTime'] as String);
    DateTime endDateTime = DateTime.parse(json['endDateTime'] as String);
    String address = json['address'] as String;
    String description = json['description'] as String;
    List<int> studentReservationIds = json['studentReservations'].cast<int>();
    List<int> wooriClassIds = json['wooriClasses'].cast<int>();

    return Event(
      id: id,
      startDateTime: startDateTime,
      endDateTime: endDateTime,
      address: address,
      description: description,
      studentReservationIds: studentReservationIds,
      wooriClassIds: wooriClassIds,
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {
      "id": this.id,
      "startDateTime": DateFormat("yyyy-MM-dd HH:mm:ss").format(this.startDateTime),
      "endDateTime": DateFormat("yyyy-MM-dd HH:mm:ss").format(this.endDateTime),
      "description": this.description,
      "wooriClasses": this.wooriClassIds,
      "studentReservations": this.studentReservationIds,
    };

    // Cleaning
    json.removeWhere((key, value) => value == null);
    return json;
  }
}
