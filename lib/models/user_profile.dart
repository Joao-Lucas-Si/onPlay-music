import 'dart:typed_data';

import 'package:objectbox/objectbox.dart';
import 'package:onPlay/models/playlist.dart';
import 'package:onPlay/models/settings/settings.dart';

@Entity()
class UserProfile {
  @Id()
  int id = 0;

  @Unique()
  String name = "";

  Uint8List? banner;
  Uint8List? photo;

  bool current;

  final settings = ToOne<DatabaseSettings>();

  @Backlink("user")
  final playlists = ToMany<Playlist>();

  UserProfile(
      {required this.name, this.banner, this.photo, this.current = false});
}
