import '../models/DailyIntake/daily_intake.dart';
import 'base_provider.dart';

class DailyIntakeProvider extends BaseProvider<DailyIntake> {
  DailyIntakeProvider() : super("DailyIntake");

  @override
  DailyIntake fromJson(data) {
    return DailyIntake.fromJson(data);
  }
}
