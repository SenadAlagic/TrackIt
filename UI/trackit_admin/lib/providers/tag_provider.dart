import '../models/Tag/tag.dart';
import 'base_provider.dart';

class TagProvider extends BaseProvider<Tag> {
  TagProvider() : super("Tag");

  @override
  Tag fromJson(data) {
    return Tag.fromJson(data);
  }
}
