import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:objectbox/objectbox.dart';
import 'package:onPlay/constants/themes/purple.dart';
import 'package:onPlay/models/music_color.dart';
import 'package:onPlay/models/song.dart';
import 'package:onPlay/models/user_profile.dart';
import 'package:collection/collection.dart';

@Entity()
class Playlist {
  @Id()
  int id = 0;

  MusicColor getColors(BuildContext context) =>
      songs.firstWhereOrNull((song) => song.picture != null)?.currentColors(
          context) ??
      purpleTheme;

  String name;

  final songs = ToMany<Song>();

  final user = ToOne<UserProfile>();

  @Transient()
  Uint8List? get image =>
      songs.firstWhereOrNull((song) => song.picture != null)?.picture;

  Playlist({required this.name});
}
