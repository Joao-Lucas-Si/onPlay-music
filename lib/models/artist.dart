import 'dart:typed_data';

import 'package:onPlay/constants/themes/purple.dart';
import 'package:onPlay/models/music_color.dart';
import 'package:onPlay/models/song.dart';
import 'package:onPlay/models/album.dart';
import 'package:objectbox/objectbox.dart';
import 'package:collection/collection.dart';
import 'package:onPlay/store/settings.dart';

@Entity()
class Artist {
  @Id()
  int id = 0;
  final String name;

  @Transient()
  Uint8List? get picture =>
      songs.firstWhereOrNull((song) => song.picture != null)?.picture;
  @Transient()
  MusicColor getColors(Settings settings) =>
      songs.firstWhereOrNull((song) => song.picture != null)?.currentColors(
          settings.interface.colorPalette, settings.interface.colorTheme) ??
      purpleTheme;

  @Backlink("artist")
  final songs = ToMany<Song>();
  @Backlink("artist")
  final albums = ToMany<Album>();

  Artist({
    required this.name,
  });

  @override
  bool operator ==(Object other) {
    if (other is Artist) {
      return (other.id != 0 && id != 0 && other.id == id) || other.name == name;
    }
    return false;
  }

  @override
  String toString() {
    // TODO: implement toString
    return "Artist(name: $name, songs: ${songs.length}, albums: ${albums.length})";
  }
}
