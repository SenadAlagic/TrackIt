import '../models/GeneralUser/general_user.dart';

class UserInfo {
  static GeneralUser? user;
  static double? bmr = 10 * weight +
      6.25 * height -
      5 * (DateTime.now().year - (user?.dateOfBirth?.year ?? 2000));
  static double height = user?.height ?? 0;
  static double weight = user?.weight ?? 0;
  static int? lastLoggedMealId;
}
