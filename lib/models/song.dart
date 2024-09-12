import 'dart:io';
import 'dart:typed_data';

import 'package:metadata_god/metadata_god.dart';
import 'package:onPlay/models/artist.dart';
import 'package:onPlay/models/album.dart';
import 'package:onPlay/models/genre.dart';
import 'package:objectbox/objectbox.dart';

@Entity()
class Song {
  // field
  @Id()
  int id = 0;
  String title;
  String path;
  int? duration;
  int? year;
  DateTime? modified;

  @Property(type: PropertyType.byteVector)
  Uint8List? picture;

  // no fields
  @Transient()
  Metadata? metadata;
  @Transient()
  FileSystemEntity? file;

  //relatioships
  final artist = ToOne<Artist>();
  final album = ToOne<Album>();
  final genre = ToOne<Genre>();

  Song(
      {required this.path,
      this.picture,
      required this.title,
      required this.duration,
      required this.year});

  Song.withFileData(
      {required this.path,
      this.picture,
      required this.title,
      this.file,
      this.metadata,
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
    return "Song{id: $id, title: $title, path: $path, duration: $duration, year: $year}";
  }
}