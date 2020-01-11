import 'package:intl/intl.dart';

class Term {
  int id;
  int term;
  List<int> staffMemberIds;
  DateTime startDate;
  DateTime endDate;
  List<int> eventIds;
  DateTime createDateTime;
  DateTime updateDateTime;

  Term({
    this.id,
    this.term,
    this.staffMemberIds,
    this.startDate,
    this.endDate,
    this.eventIds,
    this.createDateTime,
    this.updateDateTime,
  });

  factory Term.fromJson(Map<String, dynamic> json) {
    int id = json['id'] as int;
    int term = json['term'] as int;
    List<int> staffMemberIds = json['staffMembers'].cast<int>();
    DateTime startDate = DateTime.parse(json['startDate'] as String);
    DateTime endDate = DateTime.parse(json['endDate'] as String);
    List<int> eventIds = json['events'].cast<int>();
    DateTime createDateTime = DateTime.parse(json['createDateTime'] as String);
    DateTime updateDateTime = DateTime.parse(json['updateDateTime'] as String);

    return Term(
      id: id,
      term: term,
      staffMemberIds: staffMemberIds,
      startDate: startDate,
      endDate: endDate,
      eventIds: eventIds,
      createDateTime: createDateTime,
      updateDateTime: updateDateTime,
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {
      "id": this.id,
      "term": this.term,
      "staffMembers": this.staffMemberIds == null ? [] : this.staffMemberIds,
      "startDate": DateFormat("yyyy-MM-dd").format(this.startDate),
      "endDate": DateFormat("yyyy-MM-dd").format(this.endDate),
      "events": this.eventIds,
    };
    
    // Remove empty keys. Cleaning json output
    json.removeWhere((key, value) => value == null);
    return json;
  }
}
