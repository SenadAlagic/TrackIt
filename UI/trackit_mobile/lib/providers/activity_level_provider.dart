import '../models/ActivityLevel/activity_level.dart';
import 'base_provider.dart';

class ActivityLevelProvider extends BaseProvider<ActivityLevel> {
  ActivityLevelProvider() : super("ActivityLevel");

  @override
  ActivityLevel fromJson(data) {
    return ActivityLevel.fromJson(data);
  }
}
