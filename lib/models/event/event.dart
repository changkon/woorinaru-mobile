import '../user/user.dart';
import '../class/woori_class.dart';

class Event {
  int id;
  DateTime startDateTime;
  DateTime endDateTime;
  String address;
  String description;

  List<int> studentReservationIds;
  List<int> wooriClassIds;

  List<User> studentReservations;
  List<WooriClass> wooriClasses;

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
    DateTime startDateTime = json['startDateTime'] as DateTime;
    DateTime endDateTime = json['endDateTime'] as DateTime;
    String address = json['address'] as String;
    String description = json['description'] as String;
    List<int> studentReservationIds = json['studentReservations'] as List;
    List<int> wooriClassIds = json['wooriClasses'] as List;

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
}
