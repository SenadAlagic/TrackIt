import '../requests/register_request.dart';

class UserData {
  RegisterRequest? user;
  int? activityLevelId;
  int? goalId;
  List<int>? preferenceIds;

  UserData(RegisterRequest this.user);
}
