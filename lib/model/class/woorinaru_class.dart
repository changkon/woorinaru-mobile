import '../user/user.dart';
import '../event/event.dart';

enum ClassType { BEGINNER, INTERMEDIATE, TUTORING, OUTING }

class WoorinaruClass {
  int id;
  List<int> resourceIds;
  List<int> staffIds;
  List<User> staff;
  List<int> studentIds;
  List<User> students;
  int eventId;
  Event event;
  ClassType classType;
  DateTime createDateTime;
  DateTime updateDateTime;

  WoorinaruClass({
    this.id,
    this.resourceIds,
    this.staffIds,
    this.staff,
    this.studentIds,
    this.students,
    this.eventId,
    this.event,
    this.classType,
    this.createDateTime,
    this.updateDateTime,
  });

  factory WoorinaruClass.fromJson(Map<String, dynamic> json,
      [ClassType classType]) {
    int id = json['id'] as int;
    List<int> resourceIds = json['resources'].cast<int>();
    List<int> staffIds = json['staff'].cast<int>();
    List<int> studentIds = json['students'].cast<int>();
    int eventId = json['event'] as int;
    ClassType theClassType = classType;
    DateTime createDateTime = DateTime.parse(json['createDateTime'] as String);
    DateTime updateDateTime = DateTime.parse(json['updateDateTime'] as String);

    return WoorinaruClass(
      id: id,
      resourceIds: resourceIds,
      staffIds: staffIds,
      studentIds: studentIds,
      eventId: eventId,
      classType: theClassType,
      createDateTime: createDateTime,
      updateDateTime: updateDateTime,
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {
      "id": this.id,
      "resources": this.resourceIds,
      "staff": this.staffIds,
      "students": this.studentIds,
      "event": this.eventId
    };

    json.removeWhere((key, value) => value == null);
    
    return json;
  }

  String get getClassType {
    switch (this.classType) {
      case ClassType.BEGINNER:
        return "Beginner";
      case ClassType.INTERMEDIATE:
        return "Intermediate";
      case ClassType.TUTORING:
        return "Tutoring";
      case ClassType.OUTING:
        return "Outing";
    }
    return null;
  }
}
