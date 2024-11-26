import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:onPlay/dtos/json/search_dto.dart';
import 'package:onPlay/dtos/metadata_dto.dart';
import 'package:onPlay/models/artist.dart';
import 'package:onPlay/models/album.dart';
import 'package:onPlay/models/genre.dart';
import 'package:objectbox/objectbox.dart';
import 'package:onPlay/models/music_color.dart';
import 'package:onPlay/services/colors/get_base_theme.dart';
import 'package:onPlay/store/settings.dart';
import 'package:provider/provider.dart';

@Entity()
class Song {
  // field
  @Id()
  int id = 0;
  String title;
  String path;
  String? pictureMimeType;
  int? duration;
  int? year;
  DateTime? modified;

  bool isOnline;

  @Property(type: PropertyType.byteVector)
  Uint8List? picture;

  // no fields
  @Transient()
  SongMetadata? metadata;
  @Transient()
  SearchDto? videoData;
  @Transient()
  FileSystemEntity? file;

  final artist = ToOne<Artist>();
  final album = ToOne<Album>();
  final genre = ToOne<Genre>();

  final preferredColors = ToOne<MusicColor>();

  final colors = ToMany<MusicColor>();

  SongMetadata generateMetadata() => SongMetadata(
      album: album.target?.name,
      artist: artist.target?.name,
      duration: duration,
      genre: genre.target?.name,
      image: picture,
      imageMimeType: pictureMimeType,
      title: title,
      year: year);

  MusicColor currentColors(BuildContext context) {
    return preferredColors.target ?? getCurrentThemeColors(context);
  }

  MusicColor getCurrentThemeColors(BuildContext context) {
    final settings = Provider.of<Settings>(context, listen: false);
    final palette = settings.interface.colorPalette;
    final theme = settings.interface.colorTheme;
    return colors.firstWhere(
        (color) => color.palette == palette && color.theme == theme,
        orElse: () => getBaseTheme(
            Provider.of<Settings>(context, listen: false).interface.baseTheme));
  }

  Song(
      {required this.path,
      this.picture,
      required this.title,
      this.pictureMimeType,
      this.isOnline = false,
      required this.duration,
      
      required this.modified,
      required this.year});

  Song.withFileData(
      {required this.path,
      this.picture,
      this.pictureMimeType,
      required this.title,
      this.isOnline = false,
      this.file,
      this.metadata,
      required this.modified,
      required this.duration,
      required this.year});

  @override
  bool operator ==(Object other) {
    if (other is Song) {
      return (other.id != 0 && id != 0 && id == other.id) || path == other.path;
    }
    return false;
  }

  @override
  String toString() {
    return "Song{id: $id, title: $title, path: $path, duration: $duration, year: $year, colors ${colors.length}}";
  }
}
