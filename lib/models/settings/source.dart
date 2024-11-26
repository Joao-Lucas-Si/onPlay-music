import 'package:onPlay/database/objectbox.obx.dart';

@Entity()
class DatabaseSourceSettings {
  @Id()
  int id = 0;
  List<String> invidiousInstances = ["https://inv.nadeko.net/"];

  DatabaseSourceSettings({List<String>? invidiousInstances}) {
    if (invidiousInstances != null) {
      this.invidiousInstances = invidiousInstances;
    }
  }
}
