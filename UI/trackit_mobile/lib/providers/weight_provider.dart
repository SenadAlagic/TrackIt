import '../models/WeightOverTime/weight_over_time.dart';
import 'base_provider.dart';

class WeightOverTimeProvider extends BaseProvider<WeightOverTime> {
  WeightOverTimeProvider() : super("WeightOverTime");

  @override
  WeightOverTime fromJson(data) {
    return WeightOverTime.fromJson(data);
  }
}
