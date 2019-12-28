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
  });

  factory User.fromJson(Map<String, dynamic> json) {
    int id = json['id'] as int;
    String name = json['name'] as String;
    String nationality = json['nationality'] as String;
    String email = json['email'] as String;
    List<int> favouriteResources = json['favouriteResources'].cast<int>();
    DateTime signUpDateTime = DateTime.parse(json['signUpDateTime'] as String);
    StaffRole staffRole = null;
    Team team = null;

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

    return User(
      id: id,
      name: name,
      nationality: nationality,
      email: email,
      favouriteResources: favouriteResources,
      signUpDateTime: signUpDateTime,
      staffRole: staffRole,
      team: team,
    );
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
