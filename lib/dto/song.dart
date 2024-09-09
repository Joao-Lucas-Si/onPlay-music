import 'dart:io';
import 'dart:typed_data';

import 'package:metadata_god/metadata_god.dart';
import 'package:onPlay/dto/artist.dart';
import 'package:onPlay/dto/album.dart';
import 'package:onPlay/dto/genre.dart';
import 'package:objectbox/objectbox.dart';

@Entity()
class Song {
  @Id()
  int id = 0;
  String? title;
  String path;
  int? duration;
  int? year;

  @Property(type: PropertyType.byteVector)
  Uint8List? picture;

  @Transient()
  Metadata? metadata;
  @Transient()
  FileSystemEntity? file;

  final artist = ToOne<Artist>();
  final album = ToOne<Album>();
  final genre = ToOne<Genre>();

  Song(
      {required this.path,
      this.picture,
      this.title,
      required this.duration,
      required this.year});

  Song.withFileData(
      {required this.path,
      this.picture,
      this.title,
      this.file,
      this.metadata,
      required this.duration,
      required this.year});
}
