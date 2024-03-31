import '../models/Goal/goal.dart';
import 'base_provider.dart';

class GoalProvider extends BaseProvider<Goal> {
  GoalProvider() : super("Goal");

  @override
  Goal fromJson(data) {
    return Goal.fromJson(data);
  }
}
