import '../models/Preference/preference.dart';
import 'base_provider.dart';

class PreferenceProvider extends BaseProvider<Preference> {
  PreferenceProvider() : super("Preference");

  @override
  Preference fromJson(data) {
    return Preference.fromJson(data);
  }
}
