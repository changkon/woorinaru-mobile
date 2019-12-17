enum UserType { STUDENT, STAFF, ADMIN }
enum StaffRole { LEADER, VICE_LEADER, SUB_LEADER, TEACHER }

class User {
  int id;
  String name;
  String nationality;
  String email;
  List<int> favouriteResources;
  DateTime signUpDateTime;
  UserType userType;
  StaffRole staffRole;

  User({
    this.id,
    this.name,
    this.nationality,
    this.email,
    this.favouriteResources,
    this.signUpDateTime,
    this.userType,
    this.staffRole,
  });
}
