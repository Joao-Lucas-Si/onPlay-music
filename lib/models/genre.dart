import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:onPlay/constants/themes/purple.dart';
import 'package:onPlay/models/music_color.dart';
import 'package:onPlay/models/song.dart';
import 'package:objectbox/objectbox.dart';
import "package:collection/collection.dart";
import 'package:onPlay/services/colors/get_base_theme.dart';
import 'package:onPlay/store/settings.dart';
import "package:provider/provider.dart";

@Entity()
class Genre {
  @Id()
  int id = 0;
  String name;

  MusicColor getColors(BuildContext context) =>
      songs
          .firstWhereOrNull((song) => song.picture != null)
          ?.currentColors(context) ??
      getBaseTheme(context.read<Settings>().interface.baseTheme);

  @Transient()
  Uint8List? get picture =>
      songs.firstWhereOrNull((song) => song.picture != null)?.picture;

  @Backlink("genre")
  final songs = ToMany<Song>();

  Genre({required this.name});

  @override
  bool operator ==(Object other) {
    if (other is Genre) {
      return (other.id != 0 && id != 0 && other.id == id) || other.name == name;
    }
    return false;
  }

  @override
  String toString() {
    return "Genre(nome: $name, songs: ${songs.length})";
  }
}
