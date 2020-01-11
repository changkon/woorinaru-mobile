import 'package:intl/intl.dart';

enum UserType { STUDENT, STAFF, ADMIN }
enum StaffRole { LEADER, VICE_LEADER, SUB_LEADER, TEACHER }
enum Team { PLANNING, DESIGN, MEDIA, EDUCATION }

class User {
  int id;
  String name;
  String nationality;
  String email;
  List<int> favouriteResources;
  DateTime signUpDateTime;
  UserType userType;
  StaffRole staffRole;
  Team team;
  DateTime createDateTime;
  DateTime updateDateTime;
  bool isGuest;

  User({
    this.id,
    this.name,
    this.nationality,
    this.email,
    this.favouriteResources,
    this.signUpDateTime,
    this.userType,
    this.staffRole,
    this.team,
    this.createDateTime,
    this.updateDateTime,
    this.isGuest,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    int id = json['id'] as int;
    String name = json['name'] as String;
    String nationality = json['nationality'] as String;
    String email = json['email'] as String;
    List<int> favouriteResources = json['favouriteResources'].cast<int>();
    DateTime signUpDateTime = DateTime.parse(json['signUpDateTime'] as String);
    DateTime createDateTime = DateTime.parse(json['createDateTime'] as String);
    DateTime updateDateTime = DateTime.parse(json['updateDateTime'] as String);
    StaffRole staffRole = null;
    Team team = null;
    bool isGuest = false;

    if (json.keys.contains('staffRole')) {
      String staffRoleStr = json['staffRole'] as String;

      switch (staffRoleStr) {
        case "leader":
          staffRole = StaffRole.LEADER;
          break;
        case "vice_leader":
          staffRole = StaffRole.VICE_LEADER;
          break;
        case "sub_leader":
          staffRole = StaffRole.SUB_LEADER;
          break;
        case "teacher":
          staffRole = StaffRole.TEACHER;
          break;
      }
    }

    if (json.keys.contains('team')) {
      String teamStr = json['team'] as String;

      switch (teamStr) {
        case "planning":
          team = Team.PLANNING;
          break;
        case "design":
          team = Team.DESIGN;
          break;
        case "media":
          team = Team.MEDIA;
          break;
        case "education":
          team = Team.EDUCATION;
          break;
      }
    }

    if (json.keys.contains('guest')) {
      isGuest = json['guest'] as bool;
    }

    return User(
      id: id,
      name: name,
      nationality: nationality,
      email: email,
      favouriteResources: favouriteResources,
      signUpDateTime: signUpDateTime,
      staffRole: staffRole,
      team: team,
      createDateTime: createDateTime,
      updateDateTime: updateDateTime,
      isGuest: isGuest,
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {
      "id": this.id,
      "name": this.name,
      "nationality": this.nationality,
      "email": this.email,
      "favouriteResources": this.favouriteResources,
      "signUpDateTime": DateFormat("yyyy-MM-dd HH:mm:ss").format(signUpDateTime).toString(),
    };

    if (this.staffRole != null) {
      String staffRoleValue = "";
      switch (this.staffRole) {
        case StaffRole.LEADER:
          staffRoleValue = "leader";
          break;
        case StaffRole.VICE_LEADER:
          staffRoleValue = "vice_leader";
          break;
        case StaffRole.SUB_LEADER:
          staffRoleValue = "sub_leader";
          break;
        case StaffRole.TEACHER:
          staffRoleValue = "teacher";
          break;
      }

      json["staffRole"] = staffRoleValue;
    }

    if (this.team != null) {
      String teamValue = "";
      switch (this.team) {
        case Team.PLANNING:
          teamValue = "planning";
          break;
        case Team.DESIGN:
          teamValue = "design";
          break;
        case Team.MEDIA:
          teamValue = "media";
          break;
        case Team.EDUCATION:
          teamValue = "education";
          break;
      }

      json["team"] = teamValue;
    }

    if (this.team == null && this.staffRole == null) {
      json["guest"] = this.isGuest;
    }

    // Remove empty keys. Cleaning json output
    json.removeWhere((key, value) => value == null);
    return json;
  }

  String get getUserType {
    switch (userType) {
      case UserType.STAFF:
        return "Staff";
      case UserType.ADMIN:
        return "Admin";
      case UserType.STUDENT:
      default:
        return "Student";
    }
  }

  String get getStaffRole {
    switch (staffRole) {
      case StaffRole.LEADER:
        return "Leader";
      case StaffRole.VICE_LEADER:
        return "Vice Leader";
      case StaffRole.SUB_LEADER:
        return "Sub Leader";
      case StaffRole.TEACHER:
      default:
        return "Teacher";
    }
  }

  String get getTeam {
    switch (team) {
      case Team.DESIGN:
        return "Design";
      case Team.EDUCATION:
        return "Education";
      case Team.MEDIA:
        return "Media";
      case Team.PLANNING:
      default:
        return "Planning";
    }
  }
}
