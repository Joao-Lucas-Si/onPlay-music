import 'package:objectbox/objectbox.dart';

@Entity()
class DatabaseShareSettings {
  @Id()
  int id = 0;
  List<String> editorUrls = [];

  DatabaseShareSettings({required this.editorUrls});
}
