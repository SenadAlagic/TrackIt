import '../models/Admin/admin.dart';
import 'base_provider.dart';

class AdminProvider extends BaseProvider<Admin> {
  AdminProvider() : super("Admin");

  @override
  Admin fromJson(data) {
    return Admin.fromJson(data);
  }
}
