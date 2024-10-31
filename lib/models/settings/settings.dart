import 'package:objectbox/objectbox.dart';
import 'package:onPlay/models/settings/interface.dart';
import 'package:onPlay/models/settings/layout.dart';
import 'package:onPlay/models/settings/player.dart';
import 'package:onPlay/models/settings/share.dart';

@Entity()
class DatabaseSettings {
  @Id()
  int id = 0;
  var recentRange = 30;

  final interface = ToOne<DatabaseInterfaceSettings>();
  final share = ToOne<DatabaseShareSettings>();
  final layout = ToOne<DatabaseLayoutSettings>();
  final player = ToOne<DatabasePlayerSettings>();

  DatabaseSettings({required this.recentRange});
}
