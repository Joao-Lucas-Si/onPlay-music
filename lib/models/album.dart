import 'dart:typed_data';

import 'package:onPlay/constants/themes/purple.dart';
import 'package:onPlay/models/artist.dart';
import 'package:onPlay/models/music_color.dart';
import 'package:onPlay/models/song.dart';
import 'package:objectbox/objectbox.dart';
import 'package:collection/collection.dart';
import 'package:onPlay/store/settings.dart';

@Entity()
class Album {
  @Id()
  int id = 0;
  String name = "";

  @Transient()
  Uint8List? get picture =>
      songs.firstWhereOrNull((song) => song.picture != null)?.picture;

  MusicColor getColors(Settings settings) =>
      songs.firstWhereOrNull((song) => song.picture != null)?.currentColors(
          settings.interface.colorPalette, settings.interface.colorTheme) ??
      purpleTheme;

  final artist = ToOne<Artist>();

  @Backlink("album")
  final songs = ToMany<Song>();

  Album({required this.name});

  @override
  bool operator ==(Object other) {
    if (other is Album) {
      return (other.id != 0 && id != 0 && other.id == id) ||
          (other.name == name &&
              other.artist.target?.name == artist.target?.name);
    }
    return false;
  }
}
